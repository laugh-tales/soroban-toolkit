use crate::error::ToolkitError;

/// Encodes bytes to a hex string.
///
/// # Examples
/// ```
/// use soroban_toolkit::to_hex;
/// assert_eq!(to_hex(&[0xde, 0xad, 0xbe, 0xef]), "deadbeef");
/// ```
pub fn to_hex(bytes: &[u8]) -> String {
    hex::encode(bytes)
}

/// Decodes a hex string to bytes.
///
/// # Examples
/// ```
/// use soroban_toolkit::from_hex;
/// assert_eq!(from_hex("deadbeef").unwrap(), vec![0xde, 0xad, 0xbe, 0xef]);
/// ```
pub fn from_hex(s: &str) -> Result<Vec<u8>, ToolkitError> {
    hex::decode(s).map_err(|e| ToolkitError::HexDecodeError(e.to_string()))
}

/// Encodes bytes to a base64 string.
///
/// # Examples
/// ```
/// use soroban_toolkit::to_base64;
/// assert_eq!(to_base64(b"hello"), "aGVsbG8=");
/// ```
pub fn to_base64(bytes: &[u8]) -> String {
    use base64::Engine;
    base64::engine::general_purpose::STANDARD.encode(bytes)
}

/// Decodes a base64 string to bytes.
///
/// # Examples
/// ```
/// use soroban_toolkit::from_base64;
/// assert_eq!(from_base64("aGVsbG8=").unwrap(), b"hello");
/// ```
pub fn from_base64(s: &str) -> Result<Vec<u8>, ToolkitError> {
    use base64::Engine;
    base64::engine::general_purpose::STANDARD
        .decode(s)
        .map_err(|e| ToolkitError::EncodingError(e.to_string()))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_hex_roundtrip() {
        let original = b"soroban";
        assert_eq!(from_hex(&to_hex(original)).unwrap(), original);
    }

    #[test]
    fn test_base64_roundtrip() {
        let original = b"laugh-tale";
        assert_eq!(from_base64(&to_base64(original)).unwrap(), original);
    }

    #[test]
    fn test_invalid_hex() {
        assert!(from_hex("ZZZZ").is_err());
    }
}