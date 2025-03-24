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
- `transaction_format_light.S` – Lightweight format for Tor/browser
- `block_format.S` – Defines block structure
- `address_encode.S` – Encodes public key to readable address (chainID_objectID_hash)
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
- `object_create.S` – Unified creation of mainchain, tokens, smallchains, and embedded tokens
- `object_transfer.S` – Transfer logic for all object types
- `token_properties.S` – Bitwise flags for properties (divisible, mintable, chain_enabled, etc.)
- `chain_wrapper.S` – Enables chain features on token objects
- `approval_rules.S` – Quorum, multisig, delayed approvals
- `commit_reveal.S` – Secure randomness
- `pruning.S` – Deletes historical data > 5 years
- `merkle_storage.S` – Persists only Merkle roots
- `dex_logic.S` – Basic decentralized exchange logic, shared across all chains
- `explorer_logic.S` – Unified explorer for mainchain and smallchains (visibility can be toggled)
- `staking.S`, `airdrop.S`, `snapshot.S` – Token management
- `ownership_transfer.S` – Admin rights transfers
- `blacklist_whitelist.S` – Access control
- `fee_logic.S` – Custom transaction fee logic
- `vote_reputation.S` – Allows voting on reliability (fee-based)
- `auto_reputation.S` – Automatically adjusts reputation based on usage and behavior
- `marketplace_store.S` – Module for decentralized store (buy/sell/auction any tokenized asset)
- `royalty_logic.S` – Enables creators to charge royalties on reusable modules, contracts, or services

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
- `design_tokens_and_chains.md` – Explanation of unified object model (token-as-chain)

`/tools` – Dev Tools  
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

🔢 **Reputation System**
- Hybrid system for rating smallchains and tokens
- Users can vote up/down with a fee of `0.00000100 NEU` (discourages spam)
- Maximum score: 10,000 per entity
- Auto-adjustment modules may reward uptime, usage, stability
- Used to sort/filter in DEX, explorer, and UI

---

🔐 **Unified Object Model: Chains = Enhanced Tokens**
All objects (tokens, smallchains, mainchain) are created via `object_create.S` using a shared format.

**Address Format:**
Neurinochain addresses follow a structured format using chain and object IDs:
```
<chain_id>_<object_id>_<hash>
```
### Examples:
```
00_00_8d3a72f4e6c93204cb1f4e9817d4e3bc438bc4c6ef3fc03e10fc2f02e5d624a7   ; mainchain
00_01_dfd234a1ec9f0102030405060708deadbeef112233445566778899aabbcc       ; NEUR token
01_00_6fd31a084c3c1efcad308fc14a3c9eb1676db218ff607b4076beac5fc8f07e32   ; smallchain 1
01_01_abcdefabcdefabcdefabcdefabcdefabcdefabcdefabcdefabcdefabcd         ; token in SC01
```

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
- `src/modules/object_create.S`
- `src/modules/marketplace_store.S`
- `src/modules/royalty_logic.S`
- `docs/design_tokens_and_chains.md`
- `webapp/`

Pull requests and ideas are welcome!


