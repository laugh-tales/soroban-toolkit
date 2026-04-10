$repo = "laugh-tales/soroban-toolkit"

function New-Issue($title, $body) {
    Write-Host "Creating: $title"
    $tmpFile = [System.IO.Path]::GetTempFileName()
    $footer = @"

---

## Submitting Your PR
When you open a Pull Request to resolve this issue, include this line in your PR description:

``Closes #<this_issue_number>``

This will automatically close the issue when your PR is merged.

> Comment on this issue first to be assigned before starting work.
"@
    Set-Content -Path $tmpFile -Value ($body + $footer) -Encoding UTF8
    gh issue create --repo $repo --title $title --body-file $tmpFile
    Remove-Item $tmpFile
    Start-Sleep -Seconds 1
}

# --- HASHING ---

New-Issue "Implement SHA-256 hashing utility" @"
## Description
Add SHA-256 hashing support to a new ``hash`` module.

## Acceptance Criteria
- [ ] ``pub fn sha256_hex(data: &[u8]) -> String``
- [ ] ``pub fn sha256_bytes(data: &[u8]) -> Vec<u8>``
- [ ] Unit tests with known values
- [ ] Doc comments with examples

## Complexity
Trivial
"@

New-Issue "Implement SHA-512 hashing utility" @"
## Description
Add SHA-512 hashing support to the ``hash`` module.

## Acceptance Criteria
- [ ] ``pub fn sha512_hex(data: &[u8]) -> String``
- [ ] ``pub fn sha512_bytes(data: &[u8]) -> Vec<u8>``
- [ ] Unit tests with known values
- [ ] Doc comments with examples

## Complexity
Trivial
"@

New-Issue "Implement HMAC-SHA256 signing utility" @"
## Description
Add a ``hmac_sha256`` function to the ``hash`` module that takes a key and message as byte slices and returns a hex-encoded HMAC-SHA256 signature.

## Acceptance Criteria
- [ ] ``pub fn hmac_sha256(key: &[u8], message: &[u8]) -> String``
- [ ] Returns correct hex-encoded output
- [ ] Unit tests with known test vectors
- [ ] Doc comments with examples

## Complexity
Medium
"@

New-Issue "Implement Blake3 hashing utility" @"
## Description
Add Blake3 hashing support to the hash module as a faster alternative to SHA-256.

## Acceptance Criteria
- [ ] ``pub fn blake3_hex(data: &[u8]) -> String``
- [ ] ``pub fn blake3_bytes(data: &[u8]) -> Vec<u8>``
- [ ] Add ``blake3`` crate to Cargo.toml dependencies
- [ ] Unit tests with known values
- [ ] Doc comments with examples

## Complexity
Trivial
"@

New-Issue "Implement Merkle root calculator" @"
## Description
Add a function that takes a list of byte slices and computes the Merkle root hash using SHA-256.

## Acceptance Criteria
- [ ] ``pub fn merkle_root(leaves: &[&[u8]]) -> String``
- [ ] Handles odd number of leaves correctly
- [ ] Returns empty string for empty input
- [ ] Unit tests covering edge cases
- [ ] Doc comments with examples

## Complexity
High
"@

New-Issue "Implement timing-safe hash comparison utility" @"
## Description
Add a timing-safe hash comparison function to prevent timing attacks when comparing hashes.

## Acceptance Criteria
- [ ] ``pub fn secure_compare(a: &[u8], b: &[u8]) -> bool``
- [ ] Uses constant-time comparison
- [ ] Unit tests
- [ ] Doc comments explaining why timing-safe comparison matters

## Complexity
Medium
"@

New-Issue "Implement double SHA-256 hashing (hash256)" @"
## Description
Add a double SHA-256 function commonly used in blockchain contexts.

## Acceptance Criteria
- [ ] ``pub fn double_sha256(data: &[u8]) -> String``
- [ ] Unit tests with known values
- [ ] Doc comments with examples

## Complexity
Trivial
"@

# --- ADDRESS ---

New-Issue "Implement contract address validator" @"
## Description
Add a validator for Soroban contract addresses which start with 'C' instead of 'G'.

## Acceptance Criteria
- [ ] ``pub fn is_valid_contract_address(address: &str) -> bool``
- [ ] ``pub fn validate_contract_address(address: &str) -> Result<(), AddressError>``
- [ ] Unit tests covering valid and invalid cases
- [ ] Doc comments with examples

## Complexity
Trivial
"@

New-Issue "Implement batch address validator" @"
## Description
Add a function that validates multiple Stellar addresses at once and returns which are valid and which are not.

## Acceptance Criteria
- [ ] ``pub fn validate_batch(addresses: &[&str]) -> Vec<(String, bool)>``
- [ ] Returns each address paired with a validity boolean
- [ ] Unit tests with mixed valid/invalid input
- [ ] Doc comments with examples

## Complexity
Medium
"@

New-Issue "Implement address type detector" @"
## Description
Add a function that detects whether a given string is a Stellar account address, contract address, or invalid.

## Acceptance Criteria
- [ ] Create ``AddressType`` enum with variants: Account, Contract, Invalid
- [ ] ``pub fn detect_address_type(address: &str) -> AddressType``
- [ ] Unit tests
- [ ] Doc comments with examples

## Complexity
Trivial
"@

New-Issue "Implement address masking utility" @"
## Description
Add functions to mask Stellar addresses for privacy in logs and UI display.

## Acceptance Criteria
- [ ] ``pub fn mask_address(address: &str) -> String`` (shows first 4 and last 4 chars only)
- [ ] ``pub fn mask_middle(address: &str, visible: usize) -> String``
- [ ] Unit tests
- [ ] Doc comments with examples

## Complexity
Trivial
"@

New-Issue "Implement address book module" @"
## Description
Create an ``address_book`` module that allows storing and looking up labeled Stellar addresses in memory.

## Acceptance Criteria
- [ ] ``pub struct AddressBook``
- [ ] ``pub fn add(&mut self, label: &str, address: &str) -> Result<(), AddressError>``
- [ ] ``pub fn get(&self, label: &str) -> Option<&str>``
- [ ] ``pub fn remove(&mut self, label: &str) -> bool``
- [ ] ``pub fn list(&self) -> Vec<(&str, &str)>``
- [ ] Unit tests
- [ ] Doc comments

## Complexity
Medium
"@

New-Issue "Implement address diff utility" @"
## Description
Add a function that compares two lists of Stellar addresses and returns added, removed, and common addresses.

## Acceptance Criteria
- [ ] ``pub struct AddressDiff { added: Vec<String>, removed: Vec<String>, common: Vec<String> }``
- [ ] ``pub fn diff_addresses(old: &[&str], new: &[&str]) -> AddressDiff``
- [ ] Unit tests
- [ ] Doc comments with examples

## Complexity
Medium
"@

# --- ENCODING ---

New-Issue "Implement hex encoder and decoder" @"
## Description
Add hex encoding and decoding utilities to a new ``encoding`` module.

## Acceptance Criteria
- [ ] ``pub fn to_hex(bytes: &[u8]) -> String``
- [ ] ``pub fn from_hex(hex: &str) -> Result<Vec<u8>, EncodingError>``
- [ ] Unit tests with roundtrip verification
- [ ] Doc comments with examples

## Complexity
Trivial
"@

New-Issue "Implement base64 encoder and decoder" @"
## Description
Add standard base64 encoding and decoding to the ``encoding`` module.

## Acceptance Criteria
- [ ] ``pub fn to_base64(bytes: &[u8]) -> String``
- [ ] ``pub fn from_base64(s: &str) -> Result<Vec<u8>, EncodingError>``
- [ ] Unit tests with roundtrip verification
- [ ] Doc comments with examples

## Complexity
Trivial
"@

New-Issue "Implement URL-safe base64 encoder" @"
## Description
Add URL-safe base64 encoding and decoding (RFC 4648) to the encoding module.

## Acceptance Criteria
- [ ] ``pub fn to_base64_url(bytes: &[u8]) -> String``
- [ ] ``pub fn from_base64_url(s: &str) -> Result<Vec<u8>, EncodingError>``
- [ ] Unit tests with roundtrip verification
- [ ] Doc comments with examples

## Complexity
Trivial
"@

New-Issue "Implement JSON pretty printer for Soroban responses" @"
## Description
Add a utility that takes a JSON string and returns a pretty-printed, indented version for display purposes.

## Acceptance Criteria
- [ ] ``pub fn pretty_print_json(json: &str) -> Result<String, EncodingError>``
- [ ] ``pub fn minify_json(json: &str) -> Result<String, EncodingError>``
- [ ] Unit tests with valid and invalid JSON
- [ ] Doc comments with examples

## Complexity
Trivial
"@

New-Issue "Implement byte array chunker utility" @"
## Description
Add a utility that splits a byte slice into fixed-size chunks, useful for processing large contract data.

## Acceptance Criteria
- [ ] ``pub fn chunk_bytes(data: &[u8], chunk_size: usize) -> Vec<Vec<u8>>``
- [ ] ``pub fn reassemble_chunks(chunks: &[Vec<u8>]) -> Vec<u8>``
- [ ] Unit tests including edge cases (empty input, chunk larger than data)
- [ ] Doc comments with examples

## Complexity
Trivial
"@

# --- TRANSACTION ---

New-Issue "Implement XLM amount formatter (stroops to XLM)" @"
## Description
Add utilities to convert between stroops (the smallest XLM unit, 1 XLM = 10,000,000 stroops) and XLM with formatting support.

## Acceptance Criteria
- [ ] ``pub fn stroops_to_xlm(stroops: u64) -> f64``
- [ ] ``pub fn xlm_to_stroops(xlm: f64) -> u64``
- [ ] ``pub fn format_xlm(stroops: u64) -> String`` (e.g. "1.5000000 XLM")
- [ ] Unit tests with known conversions
- [ ] Doc comments with examples

## Complexity
Trivial
"@

New-Issue "Implement transaction hash validator" @"
## Description
Add a module ``transaction`` with utilities to validate and normalize Stellar transaction hashes.

## Acceptance Criteria
- [ ] ``pub fn is_valid_tx_hash(hash: &str) -> bool``
- [ ] ``pub fn normalize_tx_hash(hash: &str) -> Result<String, TxError>`` (lowercase, strip 0x prefix)
- [ ] Unit tests
- [ ] Doc comments with examples

## Complexity
Trivial
"@

New-Issue "Implement transaction fee estimator" @"
## Description
Add a fee estimation utility that calculates recommended transaction fees based on base fee and operation count.

## Acceptance Criteria
- [ ] ``pub fn estimate_fee(base_fee: u32, operation_count: u32) -> u32``
- [ ] ``pub fn estimate_fee_xlm(base_fee: u32, operation_count: u32) -> f64``
- [ ] Unit tests
- [ ] Doc comments with examples

## Complexity
Trivial
"@

New-Issue "Implement memo type validator" @"
## Description
Add a module for validating Stellar transaction memo types (text, hash, ID, return).

## Acceptance Criteria
- [ ] Create MemoType enum: None, Text(String), Hash(String), Id(u64), Return(String)
- [ ] ``pub fn validate_memo(memo: &MemoType) -> Result<(), MemoError>``
- [ ] Unit tests for each memo type including invalid cases
- [ ] Doc comments with examples

## Complexity
Medium
"@

New-Issue "Implement time bounds validator for transactions" @"
## Description
Add utilities to validate Stellar transaction time bounds (min_time and max_time).

## Acceptance Criteria
- [ ] ``pub struct TimeBounds { min_time: u64, max_time: u64 }``
- [ ] ``pub fn validate_time_bounds(bounds: &TimeBounds) -> Result<(), TxError>``
- [ ] ``pub fn is_within_bounds(bounds: &TimeBounds, current_time: u64) -> bool``
- [ ] Unit tests
- [ ] Doc comments

## Complexity
Medium
"@

New-Issue "Implement asset code validator" @"
## Description
Add validation for Stellar asset codes (native XLM, alphanumeric 4, alphanumeric 12).

## Acceptance Criteria
- [ ] Create AssetType enum: Native, Alphanumeric4, Alphanumeric12
- [ ] ``pub fn validate_asset_code(code: &str) -> Result<AssetType, AssetError>``
- [ ] Unit tests for each asset type and invalid inputs
- [ ] Doc comments with examples

## Complexity
Medium
"@

# --- CLI ---

New-Issue "Implement CLI entry point with clap" @"
## Description
Create a CLI binary entry point using the clap crate that exposes the toolkit's core functions as command-line tools.

## Acceptance Criteria
- [ ] Create ``src/main.rs``
- [ ] Subcommands: validate-address, hash, encode, decode, xlm
- [ ] Add ``clap`` with derive feature to Cargo.toml
- [ ] Help text for all commands (--help works)
- [ ] Integration tests for each subcommand

## Complexity
High
"@

New-Issue "Implement CLI address subcommand group" @"
## Description
Add a dedicated ``address`` subcommand group to the CLI.

## Acceptance Criteria
- [ ] ``soroban-toolkit address validate <ADDRESS>``
- [ ] ``soroban-toolkit address mask <ADDRESS>``
- [ ] ``soroban-toolkit address detect <ADDRESS>``
- [ ] Proper exit codes (0 = success, 1 = invalid)
- [ ] Integration tests

## Complexity
Medium
"@

New-Issue "Implement CLI hash subcommand" @"
## Description
Add a ``hash`` subcommand to the CLI that hashes input from a string argument or stdin.

## Acceptance Criteria
- [ ] ``soroban-toolkit hash sha256 <INPUT>``
- [ ] ``soroban-toolkit hash sha512 <INPUT>``
- [ ] ``soroban-toolkit hash blake3 <INPUT>``
- [ ] Supports reading from stdin using - as input
- [ ] Integration tests

## Complexity
Medium
"@

New-Issue "Implement CLI XLM formatter subcommand" @"
## Description
Add an ``xlm`` subcommand to the CLI for converting between stroops and XLM.

## Acceptance Criteria
- [ ] ``soroban-toolkit xlm to-xlm <STROOPS>``
- [ ] ``soroban-toolkit xlm to-stroops <XLM>``
- [ ] ``soroban-toolkit xlm format <STROOPS>``
- [ ] Integration tests
- [ ] Proper error messages for invalid input

## Complexity
Medium
"@

New-Issue "Add global --json output flag to CLI" @"
## Description
Add a global --json flag to the CLI that outputs all results as JSON instead of plain text.

## Acceptance Criteria
- [ ] --json flag available on all subcommands
- [ ] Output is valid, parseable JSON
- [ ] Errors also output as JSON when flag is set
- [ ] Integration tests for JSON output format

## Complexity
High
"@

# --- CI / DOCS ---

New-Issue "Add GitHub Actions CI pipeline" @"
## Description
Create a GitHub Actions workflow that runs tests, clippy, and format checks on every push and pull request.

## Acceptance Criteria
- [ ] Create ``.github/workflows/ci.yml``
- [ ] Runs ``cargo test`` on Ubuntu, Windows, macOS
- [ ] Runs ``cargo clippy -- -D warnings``
- [ ] Runs ``cargo fmt -- --check``
- [ ] Badge in README showing CI status
- [ ] Works on push to main and all PRs

## Complexity
Medium
"@

New-Issue "Create runnable examples directory" @"
## Description
Add an ``examples/`` directory with runnable example programs demonstrating each module.

## Acceptance Criteria
- [ ] ``examples/address_validation.rs``
- [ ] ``examples/hashing.rs``
- [ ] ``examples/encoding.rs``
- [ ] ``examples/xlm_formatting.rs``
- [ ] All examples run with ``cargo run --example <name>``
- [ ] Each example is well commented

## Complexity
Medium
"@

New-Issue "Add CHANGELOG.md following Keep a Changelog format" @"
## Description
Create a CHANGELOG.md following the Keep a Changelog format to track project history.

## Acceptance Criteria
- [ ] CHANGELOG.md with proper format (Unreleased, Added, Changed, Fixed sections)
- [ ] Initial entry for v0.1.0 listing all current features
- [ ] Link to changelog format spec in the file
- [ ] Mention versioning strategy briefly

## Complexity
Trivial
"@

New-Issue "Implement property-based tests for address module" @"
## Description
Add property-based tests using the ``proptest`` crate to the address module to catch edge cases automatically.

## Acceptance Criteria
- [ ] Add ``proptest`` to dev-dependencies in Cargo.toml
- [ ] Property tests for ``is_valid_stellar_address``
- [ ] Property tests for ``mask_address``
- [ ] Property tests for ``validate_address``
- [ ] All tests pass with ``cargo test``

## Complexity
High
"@

New-Issue "Implement integration test suite" @"
## Description
Create a comprehensive integration test suite in the ``tests/`` directory that tests all modules working together.

## Acceptance Criteria
- [ ] Create ``tests/integration.rs``
- [ ] Tests combining address validation + hashing
- [ ] Tests combining encoding + hashing
- [ ] Tests combining address + encoding
- [ ] All tests pass with ``cargo test``

## Complexity
High
"@

Write-Host ""
Write-Host "All issues created successfully! 🏴‍☠️" -ForegroundColor Green
