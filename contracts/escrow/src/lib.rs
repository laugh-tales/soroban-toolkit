#![no_std]

use soroban_sdk::{contract, contractimpl, contracttype, token, Address, Env, Symbol};

#[contracttype]
#[derive(Clone, Debug, Eq, PartialEq)]
pub enum EscrowStatus {
    Active,
    Released,
    Refunded,
    Disputed,
}

#[contracttype]
#[derive(Clone, Debug)]
pub struct Escrow {
    pub depositor: Address,
    pub beneficiary: Address,
    pub token: Address,
    pub amount: i128,
    pub status: EscrowStatus,
    pub release_time: u64,
}

#[contracttype]
pub enum DataKey {
    Escrow(u64),
    EscrowCount,
    Admin,
}

#[contract]
pub struct EscrowContract;

#[contractimpl]
impl EscrowContract {
    /// Initialize the contract with an admin address
    pub fn initialize(env: Env, admin: Address) {
        admin.require_auth();
        env.storage().instance().set(&DataKey::Admin, &admin);
        env.storage().instance().set(&DataKey::EscrowCount, &0u64);
    }

    /// Create a new escrow
    pub fn create_escrow(
        env: Env,
        depositor: Address,
        beneficiary: Address,
        token: Address,
        amount: i128,
        release_time: u64,
    ) -> u64 {
        depositor.require_auth();

        // Transfer tokens from depositor to contract
        let token_client = token::Client::new(&env, &token);
        token_client.transfer(&depositor, &env.current_contract_address(), &amount);

        // Get and increment escrow count
        let count: u64 = env
            .storage()
            .instance()
            .get(&DataKey::EscrowCount)
            .unwrap_or(0);
        let escrow_id = count + 1;

        // Store the escrow
        let escrow = Escrow {
            depositor,
            beneficiary,
            token,
            amount,
            status: EscrowStatus::Active,
            release_time,
        };

        env.storage()
            .instance()
            .set(&DataKey::Escrow(escrow_id), &escrow);
        env.storage()
            .instance()
            .set(&DataKey::EscrowCount, &escrow_id);

        env.events()
            .publish((Symbol::new(&env, "escrow_created"),), (escrow_id,));

        escrow_id
    }

    /// Release funds to beneficiary
    pub fn release(env: Env, escrow_id: u64) {
        let mut escrow: Escrow = env
            .storage()
            .instance()
            .get(&DataKey::Escrow(escrow_id))
            .expect("Escrow not found");

        escrow.depositor.require_auth();

        assert!(
            escrow.status == EscrowStatus::Active,
            "Escrow is not active"
        );

        let token_client = token::Client::new(&env, &escrow.token);
        token_client.transfer(
            &env.current_contract_address(),
            &escrow.beneficiary,
            &escrow.amount,
        );

        escrow.status = EscrowStatus::Released;
        env.storage()
            .instance()
            .set(&DataKey::Escrow(escrow_id), &escrow);

        env.events()
            .publish((Symbol::new(&env, "escrow_released"),), (escrow_id,));
    }

    /// Refund to depositor
    pub fn refund(env: Env, escrow_id: u64) {
        let mut escrow: Escrow = env
            .storage()
            .instance()
            .get(&DataKey::Escrow(escrow_id))
            .expect("Escrow not found");

        // Only admin can refund
        let admin: Address = env
            .storage()
            .instance()
            .get(&DataKey::Admin)
            .expect("Admin not set");
        admin.require_auth();

        assert!(
            escrow.status == EscrowStatus::Active,
            "Escrow is not active"
        );

        let token_client = token::Client::new(&env, &escrow.token);
        token_client.transfer(
            &env.current_contract_address(),
            &escrow.depositor,
            &escrow.amount,
        );

        escrow.status = EscrowStatus::Refunded;
        env.storage()
            .instance()
            .set(&DataKey::Escrow(escrow_id), &escrow);

        env.events()
            .publish((Symbol::new(&env, "escrow_refunded"),), (escrow_id,));
    }

    /// Get escrow details
    pub fn get_escrow(env: Env, escrow_id: u64) -> Escrow {
        env.storage()
            .instance()
            .get(&DataKey::Escrow(escrow_id))
            .expect("Escrow not found")
    }

    /// Get total escrow count
    pub fn get_count(env: Env) -> u64 {
        env.storage()
            .instance()
            .get(&DataKey::EscrowCount)
            .unwrap_or(0)
    }

    /// Dispute an escrow
    pub fn dispute(env: Env, escrow_id: u64) {
        let mut escrow: Escrow = env
            .storage()
            .instance()
            .get(&DataKey::Escrow(escrow_id))
            .expect("Escrow not found");

        escrow.beneficiary.require_auth();

        assert!(
            escrow.status == EscrowStatus::Active,
            "Escrow is not active"
        );

        escrow.status = EscrowStatus::Disputed;
        env.storage()
            .instance()
            .set(&DataKey::Escrow(escrow_id), &escrow);

        env.events()
            .publish((Symbol::new(&env, "escrow_disputed"),), (escrow_id,));
    }
}
