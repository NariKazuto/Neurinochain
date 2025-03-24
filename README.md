🧠 **Neurinochain**  
Neurinochain is a fully modular blockchain written in pure Assembly, optimized for slow networks, outdated hardware, and browser-based environments including Tor. It supports execution via WebAssembly (WASM), decentralized storage, and zero-installation usage.

---

🚀 **Overview**  
Neurinochain is designed to:
- Run in any browser (even Tor)
- Work on ARM and x86 devices (including Android and Raspberry Pi)
- Be modular and extendable via `.S` Assembly files
- Store only Merkle roots (no heavy databases)
- Compile to WebAssembly for client-side execution

---

📁 **Project Structure**

`/src/core` – Blockchain Runtime  
- `sign_block.S` – Signs blocks using Ed25519
- `verify_block.S` – Verifies block signatures
- `transaction_format.S` – Parses and serializes transactions
- `block_format.S` – Defines block structure
- `base58_encode.S` – Encodes wallet and token addresses
- `constants.S` – Global flags, fees, limits
- `state_storage.S` – Abstract key-value state interface
- `mainchain_init.S` – Bootstraps the mainchain

`/src/crypto` – Cryptographic Primitives  
- `ed25519_sign.S` – Ed25519 signature generation
- `ed25519_verify.S` – Signature verification
- `scalar_mul_base.S` – Scalar * base point
- `field_add.S`, `field_sub.S`, `field_mul.S`, `field_square.S`, `field_reduce.S` – Finite field operations
- `sha512.S` – SHA-512 hash function
- `keccak256.S` – Optional hash for interoperability

`/src/modules` – Blockchain Extensions  
- `smallchain_create.S` – Creates isolated smart-token chains
- `smallchain_update.S` – Modifies chain settings
- `token_create.S`, `token_transfer.S` – Token system logic
- `approval_rules.S` – Quorum, multisig, delayed approvals
- `commit_reveal.S` – Secure randomness
- `pruning.S` – Deletes historical data > 5 years
- `merkle_storage.S` – Persists only Merkle roots
- `dex_logic.S` – Basic decentralized exchange logic
- `staking.S`, `airdrop.S`, `snapshot.S` – Token management
- `ownership_transfer.S` – Admin rights transfers
- `blacklist_whitelist.S` – Access control
- `fee_logic.S` – Custom transaction fee logic

`/wasm` – Compiled WebAssembly Modules  
- `core_runtime.wasm`
- `sha512.wasm`
- `ed25519.wasm`
- *(others as needed)*

`/webapp` – Browser Interface  
- `index.html` – Minimal DApp frontend
- `style.css` – Styling
- `wallet.js` – Wallet generation, signing, balance
- `wasm_loader.js` – JS loader for WebAssembly modules

`/assets/` – Optional static files  

`/docs` – Documentation  
- `specs.md` – Full blockchain specs
- `wasm_build.md` – Build guide for `.S → .wasm`
- `tor_optimizations.md` – Run Neurinochain over Tor
- `browser_support.md` – Compatibility matrix

`/tools` – Dev Tools  
- `base58_encoder.py` – Base58 wallet encoder
- `keygen.py` – Generates Ed25519 keys
- `wasm_builder.sh` – Compiles Assembly into WebAssembly

`/test_vectors` – Cryptographic Testing  
- `/ed25519/` – Test signatures
- `/sha512/` – Test hashes

---

🌐 **WASM + Tor Design**
- All blockchain logic runs in the browser via WebAssembly
- Tor-friendly: no remote APIs, no CDN, zero tracking
- Storage relies on Merkle roots only
- No full-node install required
- Everything can be deployed over IPFS or `.onion`

---

⛓️ **Block Generation Timing**
- **Mainchain**: 30 seconds per block (optimized for Tor)
- **Smallchains**: 30–60 seconds (configurable)
- **Sync bursts supported**: up to 10 blocks/second

---

✅ **Why Neurinochain?**
- Full blockchain execution inside Tor Browser
- Works on old devices (ARM/x86)
- Decentralized, modular, and offline-capable
- Designed for education, experimentation, and frontier use

---

📜 **License**
MIT — open to use, study, remix, or contribute.

---

🙌 **Want to contribute?**
Start with:
- `docs/specs.md`
- `src/core/`
- `webapp/`

Pull requests and ideas are welcome!


