use crate::error::ToolkitError;

/// Checks if a Stellar address is valid.
/// A valid Stellar address starts with 'G' and is exactly 56 characters long.
///
/// # Examples
/// ```
/// use soroban_toolkit::is_valid_stellar_address;
/// assert!(is_valid_stellar_address("GBBD47IF6LWK7P7MDEVSCWR7DPUWV3NY3DTQEVFL4NAT4AQH3ZLLFLA5"));
/// assert!(!is_valid_stellar_address("BADINPUT"));
/// ```
pub fn is_valid_stellar_address(address: &str) -> bool {
    address.starts_with('G') && address.len() == 56
        && address.chars().all(|c| c.is_ascii_alphanumeric())
}

/// Shortens a Stellar address for display purposes.
/// e.g. "GAAZI4TCR3T...CCWN"
///
/// # Examples
/// ```
/// use soroban_toolkit::shorten_address;
/// let short = shorten_address("GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN");
/// assert_eq!(short, "GAAZI4TCR3T...CCWN");
/// ```
pub fn shorten_address(address: &str) -> String {
    if address.len() < 16 {
        return address.to_string();
    }
    format!("{}...{}", &address[..11], &address[address.len() - 4..])
}

/// Validates a Stellar address and returns an error if invalid.
///
/// # Examples
/// ```
/// use soroban_toolkit::validate_address;
/// assert!(validate_address("GBBD47IF6LWK7P7MDEVSCWR7DPUWV3NY3DTQEVFL4NAT4AQH3ZLLFLA5").is_ok());
/// assert!(validate_address("BADINPUT").is_err());
/// ```
pub fn validate_address(address: &str) -> Result<(), ToolkitError> {
    if is_valid_stellar_address(address) {
        Ok(())
    } else {
        Err(ToolkitError::InvalidAddress(address.to_string()))
    }
}

#[cfg(test)]
mod tests {
    use super::*;

   const VALID: &str = "GBBD47IF6LWK7P7MDEVSCWR7DPUWV3NY3DTQEVFL4NAT4AQH3ZLLFLA5";

    #[test]
    fn test_valid_address() {
        assert!(is_valid_stellar_address(VALID));
    }

    #[test]
    fn test_invalid_address_short() {
        assert!(!is_valid_stellar_address("GSHORT"));
    }

    #[test]
    fn test_invalid_address_wrong_prefix() {
        assert!(!is_valid_stellar_address("BAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN"));
    }

#[test]
fn test_shorten_address() {
    let result = shorten_address(VALID);
    assert!(result.contains("..."));
    assert!(result.starts_with("GBBD47IF6LW"));
}

    #[test]
    fn test_validate_address_ok() {
        assert!(validate_address(VALID).is_ok());
    }

    #[test]
    fn test_validate_address_err() {
        assert!(validate_address("BADINPUT").is_err());
    }
}