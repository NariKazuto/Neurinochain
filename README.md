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

- Blocks every **30 seconds** (mainchain)
- **Sync burst**: up to **10 blocks/sec** for catch-up
- Browser-only interface using WebAssembly (no install)
- Low bandwidth Merkle-only storage (no DB)
- `.onion` relay/node supported
- Full staking, DEX and reward logic runs client-side

---

## 🔐 Address Format (Base32-only)

All objects (wallets, tokens, chains, etc.) are identified by their **Base32-encoded SHA-512 hash**.

```text
MFZXKZ3WOBSWIIDTNF2HI3DJNZTGS4TDL5XGIY3JLFBQ
```

The metadata (chain, object type, etc.) is recorded in the `object_registry`, not inside the address.

---

## 🧾 Object Registry

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

---

## 🔄 Staking & Block Consensus (Mainchain)

- Wallets with **≥ minimum NEU** in staking can participate
- **Node with highest stake** gets priority if synchronized
- If node is desynced → first available synced node takes over
- If another synced node is waiting → block creator cedes on completion
- If a node created **10 blocks in the last 2880**, it's excluded for 2880

### 🧠 Reward Logic (per block)
- **10 NEU created magically** (invisible minting)
- **All fees collected** in the block
- Distributed **proportionally** to active (synced) stakers
- **Winning node gets +10% bonus** on its proportional share
- Nodes not synced = ❌ no rewards
- Rewards are **credited to spendable balance**, but:
  - Not automatically staked
  - Must sell **≥ 50% of rewards in DEX** or be blocked

### 📈 Difficulty / Inflation Control (every 2880 blocks)
- **Staking minimum** increases by **0.0567%**
- **NEU penalty of -0.0567%** to nodes under quota (given to forger)
- **New NEU minted** = 0.0567% of total staked
- Minted NEU are placed **directly in the DEX** at +0.0567% price
- No tx recorded — appears as automatic DEX liquidity

---

## 🔄 Transactions

Transactions are recorded with:
- `from`, `to` = Base32 addresses
- `amount`, `fee`
- optional `data`

Only user-initiated tx are part of the Merkle root.
Reward logic is excluded.

---

## 🧱 Block Format

Each block includes:
- `timestamp`
- `previous_block_hash`
- `merkle_root` (of txs only)
- `forger_public_key`
- `signature` (Ed25519)

And special **invisible fields**, excluded from Merkle:
- `reward_neu` = 10 NEU block reward
- `reward_fee_total` = total tx fees in block
- Used only in consensus modules

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
- `staking_main.S`, `dex_liquidity_mint.S`
- `dex_logic.S`, `marketplace_store.S`, `royalty_logic.S`
- `vote_reputation.S`, `auto_reputation.S`, `blacklist_whitelist.S`
- `airdrop.S`, `snapshot.S`, `fee_logic.S`, `pruning.S`, `merkle_storage.S`

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
```bash
ipfs add -r webapp/  # optional legacy
```

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
- Merkle root verifies user tx only
- Rewards are stored separately and verified in module logic

---

## ✅ Why Neurinochain?

- No database required
- Pure Assembly + WASM = light and modular
- Browser and Tor-friendly
- Verifiable via Merkle root only
- Reward and inflation logic handled off-chain invisibly

---

## 📜 License

MIT — open to use, modify, contribute, or fork.

---

## 🙌 Contribute

Start from:
- `src/core/mainchain_init.S`
- `src/modules/object_create.S`
- `src/modules/object_properties.S`
- `src/modules/staking_main.S`
- `src/modules/dex_liquidity_mint.S`
- `docs/specs.md`
- `webapp/index.html`

Pull requests welcome!

