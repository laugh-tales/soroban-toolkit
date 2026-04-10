use sha2::{Sha256, Digest};

/// Hashes input bytes using SHA-256 and returns a hex string.
///
/// # Examples
/// ```
/// use soroban_toolkit::sha256_hex;
/// let result = sha256_hex(b"hello");
/// assert_eq!(result.len(), 64);
/// ```
pub fn sha256_hex(data: &[u8]) -> String {
    let mut hasher = Sha256::new();
    hasher.update(data);
    hex::encode(hasher.finalize())
}

/// Hashes input bytes using SHA-256 and returns raw bytes.
pub fn sha256_bytes(data: &[u8]) -> Vec<u8> {
    let mut hasher = Sha256::new();
    hasher.update(data);
    hasher.finalize().to_vec()
}

/// Double SHA-256 hash (used in many blockchain protocols).
pub fn double_sha256(data: &[u8]) -> Vec<u8> {
    sha256_bytes(&sha256_bytes(data))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_sha256_hex_length() {
        assert_eq!(sha256_hex(b"test").len(), 64);
    }

    #[test]
    fn test_sha256_known_value() {
        // SHA-256 of empty string is known
        let result = sha256_hex(b"");
        assert_eq!(
            result,
            "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
        );
    }

    #[test]
    fn test_double_sha256_length() {
        assert_eq!(double_sha256(b"data").len(), 32);
    }
}