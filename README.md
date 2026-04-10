# 🔐 Soroban Escrow Platform

A decentralized escrow smart contract platform built on the Stellar blockchain using Soroban. Lock funds, set conditions, and release payments trustlessly — no intermediaries needed.

[![CI](https://github.com/laugh-tales/soroban-toolkit/actions/workflows/ci.yml/badge.svg)](https://github.com/laugh-tales/soroban-toolkit/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Rust](https://img.shields.io/badge/rust-1.75%2B-blue.svg)](https://www.rust-lang.org)

---

## 🌊 What is Soroban Escrow?

Soroban Escrow is an open-source decentralized escrow system built on Stellar's Soroban smart contract platform. It enables trustless peer-to-peer transactions where funds are held securely in a smart contract until predefined conditions are met.

**Use cases:**
- Freelance payments — pay only when work is delivered
- P2P trading — trade assets without trusting a counterparty
- Milestone-based contracts — release funds as milestones are completed
- Dispute resolution — built-in dispute mechanism with admin arbitration

---

## ✨ Features

- **Trustless Escrow** — Funds locked in Soroban smart contract, no custodian
- **Multi-token Support** — Works with any Stellar/Soroban token
- **Dispute System** — Beneficiary can raise disputes, admin arbitrates
- **Event Logging** — Full on-chain event trail for every action
- **Utility Library** — Rich Rust toolkit for Soroban developers
- **CLI Tool** — Command-line interface for interacting with contracts

---

## 🏗️ Project Structure
---

## 🚀 Quick Start

### Prerequisites

- [Rust](https://rustup.rs/) 1.75+
- [Soroban CLI](https://developers.stellar.org/docs/smart-contracts/getting-started/setup)
- [Stellar Account](https://developers.stellar.org/docs/smart-contracts/getting-started/setup#configure-an-identity)

### Installation

```bash
git clone https://github.com/laugh-tales/soroban-toolkit
cd soroban-toolkit
cargo build
```

### Run Tests

```bash
cargo test
```

### Deploy the Escrow Contract

```bash
# Build the contract
soroban contract build --manifest-path contracts/escrow/Cargo.toml

# Deploy to testnet
soroban contract deploy \
  --wasm target/wasm32-unknown-unknown/release/soroban_escrow.wasm \
  --network testnet \
  --source YOUR_ACCOUNT
```

### Use the CLI

```bash
# Validate a Stellar address
cargo run -- address validate GBBD47IF6LWK7P7MDEVSCWR7DPUWV3NY3DTQEVFL4NAT4AQH3ZLLFLA5

# Hash data
cargo run -- hash sha256 "hello world"

# Convert XLM to stroops
cargo run -- xlm to-stroops 10.5
```

---

## 📜 Smart Contract — How It Works

### 1. Create an Escrow

The depositor locks funds into the contract specifying a beneficiary, token, amount, and release time.

```rust
let escrow_id = client.create_escrow(
    &depositor,
    &beneficiary,
    &token_address,
    &amount,
    &release_time,
);
```

### 2. Release Funds

Once satisfied with the work, the depositor releases funds to the beneficiary.

```rust
client.release(&escrow_id);
```

### 3. Dispute

If there's a disagreement, the beneficiary can raise a dispute for admin arbitration.

```rust
client.dispute(&escrow_id);
```

### 4. Refund

Admin can refund the depositor if the dispute is resolved in their favor.

```rust
client.refund(&escrow_id);
```

---

## 🛠️ Utility Library

The toolkit also includes a rich Rust utility library for Soroban developers:

```rust
use soroban_toolkit::{
    validate_address, shorten_address,   // Address utilities
    sha256_hex, blake3_hex,              // Hashing
    to_hex, from_base64,                 // Encoding
    stroops_to_xlm, format_xlm,          // XLM formatting
};

// Validate a Stellar address
assert!(validate_address("GBBD47IF6LWK7P7MDEVSCWR7DPUWV3NY3DTQEVFL4NAT4AQH3ZLLFLA5").is_ok());

// Hash some data
let hash = sha256_hex(b"soroban");

// Format XLM amount
println!("{}", format_xlm(10_000_000)); // "1.0000000 XLM"
```

---

## 🤝 Contributing

We welcome contributions! This project is part of the **Stellar Wave Program** on Drips — contributors can earn rewards for resolving issues.

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Good First Issues

Browse our [open issues](https://github.com/laugh-tales/soroban-toolkit/issues) — all labeled with complexity levels:
- 🟢 **Trivial** — Small fixes, docs, tests
- 🟡 **Medium** — New features, improvements  
- 🔴 **High** — Complex features, new modules

---

## 📄 License

MIT License — see [LICENSE](LICENSE) for details.

---

## 🔗 Links

- [Stellar Developers](https://developers.stellar.org)
- [Soroban Docs](https://soroban.stellar.org)
- [Drips Wave Program](https://drips.network/wave/stellar)
- [Discord](#) — Coming soon