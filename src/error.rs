use thiserror::Error;

#[derive(Debug, Error, PartialEq)]
pub enum ToolkitError {
    #[error("Invalid Stellar address: {0}")]
    InvalidAddress(String),

    #[error("Hex decode error: {0}")]
    HexDecodeError(String),

    #[error("Encoding error: {0}")]
    EncodingError(String),
}