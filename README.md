<p align="center">
  <img src="https://raw.githubusercontent.com/NariKazuto/Neurinochain/main/nuologo256.png" alt="Neurinochain logo" width="128" />
</p>


# 🧠 Neurinochain

**Neurinochain** is a fully modular blockchain written in pure Assembly, optimized for slow networks, outdated hardware, and privacy-preserving environments such as Tor. It supports WebAssembly (WASM), zero-installation browser usage, and decentralized Merkle-based storage.

---

## 🚀 Overview

- Runs in any browser (even **Tor**)
- Compatible with x86, ARM, Android, Raspberry Pi
- Modular logic via `.S` Assembly files
- No heavy databases — only Merkle roots are stored
- Fully compilable to **WebAssembly**
- Zero-tracking, zero-CDN, and anonymous by design
- Optional `.onion` support via local Tor relay

---

## 📁 Project Structure

```
/src/core/       → Core runtime (block structure, signing, state)
/src/crypto/     → Ed25519, SHA-512, field arithmetic
/src/modules/    → Token, chain, voting, staking, DEX, reputation...
/src/tools/      → Local simulation, wallet generation, testing
/webapp/         → Minimal WASM-based DApp (runs in Tor Browser)
/docs/           → Specs and developer guides
```

---

## 🌐 Tor + WASM Friendly Design

- Blocks every **30 seconds** (mainchain), up to **10 blocks/sec sync burst**
- Tor-optimized propagation
- `.onion` relay/node support (`torrc + HiddenService`)
- Browser-only interface using WebAssembly (no install)
- Low bandwidth + Merkle-only storage
- Full wallet and DEX usable over Tor

---

## 🔐 Address Format

All blockchain objects follow this canonical format:
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

## 🔄 Transactions & Fee Handling

Transactions are chain-specific and object-specific. Each includes:
- `from`, `to`
- `chain_id`, `object_id`
- `amount`, `fee`
- optional `data` (DEX, vote, staking, etc.)

Fees are handled in a **hybrid mode**:
- ✅ **Visible in transactions**: fee amounts are signed and recorded in Merkle root
- ❌ **Distribution is invisible**: the total fee is distributed to staking nodes without a transaction

Rewards and fees are written directly into the block metadata and state — but never included in the Merkle root.

---

## 🧱 Block Format

- Timestamp
- Previous block hash
- Merkle root (only includes user transactions)
- Generator address (forger)
- Signature (Ed25519)
- `reward_neu` = 10 NEU (magically created)
- `reward_fee_total` = aggregated from txs, distributed invisibly

---

## 🧠 Rewards: "Merkle-Free" Logic

Neurinochain uses off-Merkle logic for specific protocol-level rewards:

| Reward Type          | Merkle Root | Notes                                           |
|----------------------|-------------|-------------------------------------------------|
| Staking block reward | ❌ No       | 10 NEU minted per block, distributed directly   |
| Fee distribution     | ❌ No       | Aggregated from txs, rewarded invisibly         |
| DEX liquidity mint   | ❌ No       | Extra NEU created every 2880 blocks             |
| User transactions    | ✅ Yes      | Normal behavior, fully signed + hashed          |

This design allows:
- Fast block validation
- Smaller Merkle trees
- WASM-ready validation in browser or Tor

---

## 🔧 Modular Architecture

Assembly modules by category:

### `/src/core/`
- `mainchain_init.S`, `block_format.S`
- `sign_block.S`, `verify_block.S`
- `state_storage.S`, `address_encode.S`, `constants.S`

### `/src/modules/`
- `object_create.S`, `object_transfer.S`
- `object_properties.S`, `object_registry.S`
- `staking_main.S`, `dex_logic.S`, `fee_logic.S`
- `vote_reputation.S`, `airdrop.S`, `snapshot.S`
- `blacklist_whitelist.S`, `royalty_logic.S`
- `chain_wrapper.S`, `approval_rules.S`, `merkle_storage.S`

### `/src/tools/`
- `localmain_start.S`, `simulator_local_wallets.S`
- `simulator_cycle_blocks.S`, `simulator_sync_status.S`

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

Serve `/webapp` folder via local server or IPFS:
```
ipfs add -r webapp/
```

Works out of the box on **Tor Browser**.

---

## 😅 Tor Integration (Advanced)

1. Install Tor on your server
2. Add a hidden service in `torrc`:
```
HiddenServiceDir /var/lib/tor/neurino/
HiddenServicePort 9030 127.0.0.1:9030
```

3. Your Neurino node will be reachable at:
```
neurinoabcd234xyz.onion:9030
```

---

## ✅ Why Neurinochain?

- No database required
- Compatible with browsers, mobile, and low-end devices
- Full functionality on Tor `.onion`
- Educational, experimental, privacy-focused

---

## 📜 License

MIT — open to use, modify, contribute, or fork.

---

## 🙌 Contribute

Start from:
- `src/core/mainchain_init.S`
- `src/modules/object_create.S`
- `src/modules/staking_main.S`
- `src/modules/fee_logic.S`
- `docs/specs.md`
- `webapp/index.html`

Pull requests are welcome!

