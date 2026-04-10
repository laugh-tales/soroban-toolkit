#[derive(Debug)]
pub enum TxError {
    InvalidHash,
    InvalidFee,
    InvalidSequence,
    InvalidTimeBounds,
    InvalidAssetCode,
}

impl std::fmt::Display for TxError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            TxError::InvalidHash => write!(f, "Invalid transaction hash"),
            TxError::InvalidFee => write!(f, "Invalid fee"),
            TxError::InvalidSequence => write!(f, "Invalid sequence number"),
            TxError::InvalidTimeBounds => write!(f, "Invalid time bounds"),
            TxError::InvalidAssetCode => write!(f, "Invalid asset code"),
        }
    }
}

/// Converts stroops to XLM (1 XLM = 10,000,000 stroops)
pub fn stroops_to_xlm(stroops: u64) -> f64 {
    stroops as f64 / 10_000_000.0
}

/// Converts XLM to stroops
pub fn xlm_to_stroops(xlm: f64) -> u64 {
    (xlm * 10_000_000.0).round() as u64
}

/// Formats stroops as a readable XLM string
pub fn format_xlm(stroops: u64) -> String {
    format!("{:.7} XLM", stroops_to_xlm(stroops))
}

/// Validates a Stellar transaction hash (64 hex characters)
pub fn is_valid_tx_hash(hash: &str) -> bool {
    hash.len() == 64 && hash.chars().all(|c| c.is_ascii_hexdigit())
}

/// Normalizes a transaction hash (lowercase, strip 0x prefix)
pub fn normalize_tx_hash(hash: &str) -> Result<String, TxError> {
    let h = hash.strip_prefix("0x").unwrap_or(hash).to_lowercase();
    if is_valid_tx_hash(&h) {
        Ok(h)
    } else {
        Err(TxError::InvalidHash)
    }
}

/// Estimates transaction fee in stroops
pub fn estimate_fee(base_fee: u32, operation_count: u32) -> u32 {
    base_fee * operation_count
}

/// Estimates transaction fee in XLM
pub fn estimate_fee_xlm(base_fee: u32, operation_count: u32) -> f64 {
    stroops_to_xlm(estimate_fee(base_fee, operation_count) as u64)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_stroops_to_xlm() {
        assert_eq!(stroops_to_xlm(10_000_000), 1.0);
        assert_eq!(stroops_to_xlm(5_000_000), 0.5);
    }

    #[test]
    fn test_xlm_to_stroops() {
        assert_eq!(xlm_to_stroops(1.0), 10_000_000);
        assert_eq!(xlm_to_stroops(0.5), 5_000_000);
    }

    #[test]
    fn test_format_xlm() {
        assert_eq!(format_xlm(10_000_000), "1.0000000 XLM");
    }

    #[test]
    fn test_valid_tx_hash() {
        let hash = "a".repeat(64);
        assert!(is_valid_tx_hash(&hash));
        assert!(!is_valid_tx_hash("short"));
    }

    #[test]
    fn test_estimate_fee() {
        assert_eq!(estimate_fee(100, 3), 300);
    }
}
