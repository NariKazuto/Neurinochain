<p align="center">
  <img src="https://raw.githubusercontent.com/NariKazuto/Neurinochain/main/neulogo256.png" alt="Neurinochain logo" width="128" />
</p>

# 🧠 Neurinochain

**Neurinochain** is a fully modular blockchain written in pure Assembly, optimized for slow networks, outdated hardware, and privacy-preserving environments such as Tor. It supports WebAssembly (WASM), zero-installation browser usage, and decentralized Merkle-based storage.

---

## 🚀 Overview

- Runs in any browser (even **Tor**)
- Compatible with x86, ARM, Android, Raspberry Pi
- Modular logic via `.S` Assembly files
- No heavy databases — only **Merkle roots per block are stored**
- Fully compilable to **WebAssembly**
- Zero-tracking, zero-CDN, and anonymous by design
- Optional `.onion` support via local Tor relay

---

## 📁 Project Structure

```
/src/core/       → Core runtime (block structure, signing, state)
/src/crypto/     → Ed25519, SHA-512, field arithmetic
/src/modules/    → Object creation, DEX, voting, staking, reputation...
/webapp/         → Minimal WASM-based DApp (runs in Tor Browser)
/docs/           → Specs and developer guides
/tools/          → Keygen, WASM builder, test tools
```

---

## 🌐 Tor + WASM Friendly Design

- Blocks every **30 seconds** (mainchain), up to **10 blocks/sec sync burst**
- Tor-optimized propagation
- `.onion` relay/node support (`torrc + HiddenService`)
- Browser-only interface using WebAssembly (no install)
- **Merkle root per block** only — no state DB
- Full wallet and DEX usable over Tor

---

## 🔐 Address Format (Base32-only)

All objects (wallets, tokens, chains, etc.) are identified by their **Base32-encoded SHA-512 hash**.

No need for chain_id or object_id prefixes inside the address itself.

```text
MFZXKZ3WOBSWIIDTNF2HI3DJNZTGS4TDL5XGIY3JLFBQ
```

The metadata (chain, object type, etc.) is recorded separately in the chain state and used by the DApp and WASM modules.

---

## 🔍 Object Registry

Every object (wallet, token, chain, contract...) is represented by its Base32 SHA-512 hash.
To understand its role and metadata, Neurinochain uses an **`object_registry`**, included in the chain state and referenced in block files.

Example entry:

```json
{
  "id": "MFZXKZ3WOBSWIIDTNF2HI3DJNZTGS4TDL5XGIY3JLFBQ",
  "type": "wallet",
  "chain_context": "00",
  "owner": "MFZX...",
  "created_in_block": 20,
  "properties": {
    "name": "NEUR Token",
    "divisible": true,
    "mintable": false
  }
}
```

- Stored inside block state
- Verifiable via Merkle root
- Required for DApp logic and WASM interpretation

---

## 🔄 Transactions

Transactions are recorded with:
- `from`, `to` = Base32 addresses
- `amount`, `fee`
- optional `data`

Transactions are hashed and signed. The `merkle_root` of each block summarizes all tx hashes for that block.

---

## 🧱 Block Format

Each block includes:

- `timestamp`
- `previous_block_hash`
- `merkle_root` (hash of txs)
- `generator_public_key`
- `signature` (Ed25519)

All saved as signed `.json` objects — no database required.

---

## 🔧 Modular Architecture

Assembly modules by category:

### `/src/core/`
- `sign_block.S`, `verify_block.S` — Ed25519-based consensus
- `state_storage.S` — Merkle root interface
- `block_format.S`, `transaction_format_light.S`
- `constants.S`, `address_encode.S`, `mainchain_init.S`

### `/src/modules/`
- `object_create.S`, `object_transfer.S`
- `object_properties.S`, `approval_rules.S`, `chain_wrapper.S`
- `dex_logic.S`, `marketplace_store.S`, `royalty_logic.S`
- `vote_reputation.S`, `auto_reputation.S`, `blacklist_whitelist.S`
- `staking.S`, `staking_main.S`, `airdrop.S`, `snapshot.S`
- `fee_logic.S`, `pruning.S`, `merkle_storage.S`

---

## 📊 Reputation System

- Score from 0 to 10,000
- Voting requires 0.00000100 NEU fee
- Used for sorting and filtering in DEX and explorer
- Auto-adjustments based on usage, uptime, and stability

---

## 🛠️ Build & Run

### Compile WASM

```bash
./tools/wasm_builder.sh
```

### Run in browser

Serve `/webapp` folder via local server or `.onion`:
```
ipfs add -r webapp/  # optional legacy
```

Works out of the box on **Tor Browser**.

---

## 😅 Minimal Explorer (No Backend)

Neurinochain uses signed `.json` block files:
```json
{
  "height": 12345,
  "timestamp": 1711305700,
  "merkle_root": "ZC8QWBNEVWO6Z4IX57U5VGJ37ZPYUVVV...",
  "transactions": [ "hash1", "hash2", ... ],
  "signature": "..."
}
```

WASM modules validate Merkle root and parse contents locally.
No need for remote API, database, or full-node.

---

## ✅ Why Neurinochain?

- No database required
- Pure Assembly + WASM = light and modular
- Browser and Tor-friendly
- Verifiable via Merkle root only
- Education-ready, censorship-resistant

---

## 📜 License

MIT — open to use, modify, contribute, or fork.

---

## 🙌 Contribute

Start from:
- `src/core/mainchain_init.S`
- `src/modules/object_create.S`
- `src/modules/object_properties.S`
- `src/core/address_encode.S`
- `docs/specs.md`
- `webapp/index.html`

Pull requests welcome!

