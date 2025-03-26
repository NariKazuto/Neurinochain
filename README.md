<img src="https://raw.githubusercontent.com/NariKazuto/Neurinochain/main/neulogo256.png" alt="Neurinochain logo" width="128" />

# 🧠 Neurinochain

**Neurinochain** is a fully modular blockchain written entirely in Assembly, designed for extreme efficiency, stateless operation, and compatibility with low-power devices and browsers.

It features:
- Full execution in the browser via WebAssembly (no installation needed)
- Stateless core with only Merkle roots saved
- Auto-scaling reward system and tokenized structure
- Invisible reward minting and transaction-level privacy
- Built-in decentralized DEX and automatic reputation system

---

## 🚀 Key Features

- Runs on any browser or OS (including Raspberry Pi, Android, Linux)
- Uses only WebAssembly and static assets (HTML/CSS/JS)
- Supports both full mainchain and modular "smallchains"
- Every object is a token: mainchain, tokens, smallchains, DEX orders
- Zero database: only Merkle roots are saved
- Invisible staking rewards and automatic DEX liquidity
- No Tor required (but optionally compatible)
- Fully customizable fee system per operation
- User-loadable modules per smallchain

---

## 🧱 Stateless Architecture

Neurinochain uses a "pure state" model:
- Transactions are **autodestroyed** after processing and 51% sync confirmations
- Only the **Merkle root of current state** is saved per block
- No transaction logs or historical data needed
- Perfect for low storage environments and private usage

---

## 🔐 Address Format & Object ID Structure

Neurinochain uses a strict and expandable ID structure to identify all objects in the network.

### 🔹 Prefix Format: `CHAIN_ID`_`OBJECT_ID`_`TYPE_ID`_

| Segment       | Description                         | Example         |
|---------------|-------------------------------------|-----------------|
| `CHAIN_ID`    | The chain the object belongs to     | `00_` = mainchain, `01_` = smallchain 1, etc. |
| `OBJECT_ID`   | Object type scope (native or user)  | `00_` = native object in that chain          |
| `TYPE_ID`     | Type of object                      | `T_`, `W_`, `D_`, `OBJ_`                     |

### 🔹 Object Type Examples

| Object              | Prefix Example            | Description                                      |
|---------------------|---------------------------|--------------------------------------------------|
| **Mainchain token** | `00_00_T_ABC...`          | Token on mainchain                              |
| **Wallet (main)**   | `00_00_W_XYZ...`          | Wallet operating on mainchain                   |
| **DEX Order (main)**| `00_00_D_DEF...`          | Order registered on mainchain DEX               |
| **Token (small)**   | `01_00_T_ABC...`          | Native token on smallchain #1                   |
| **Wallet (small)**  | `01_00_W_...`             | Wallet scoped to smallchain #1                  |
| **DEX (small)**     | `01_00_D_...`             | DEX orders in smallchain #1                     |
| **Custom object**   | `00_00_OBJ_...`           | Unregistered user module, not verified by chain |

### ✅ All identifiers follow this format:
```
[CHAIN_ID]_[OBJECT_ID]_[TYPE_ID]_[ENCODED_BODY]
```
- Encoded body is always Base32, no padding
- Length and prefix validate the structure

---

## 📁 Project Structure

```
/src/core/         → Consensus, block layout, base encoding
/src/modules/      → All token, chain, transfer and DEX logic
/src/crypto/       → Ed25519, SHA-512, Keccak, field math
/src/fees/         → Global fee definitions for all operations
/src/custom/       → Custom module loaders for smallchains (exposed as OBJ_)
/wasm/             → Compiled WebAssembly modules
/webapp/           → WASM browser client (HTML/CSS/JS)
/docs/             → Specs and technical guides
/tools/            → Keygen, builder scripts, dev tools
```

---

## 💸 Reward Logic

- Every block mints **10 NEU** magically (not via transaction)
- Fees are also distributed magically — only the result appears in wallet balances
- No reward or fee distribution is included in the Merkle root or transaction list
- All rewards are added directly to wallet balances as state changes

### Distribution:
- Rewards are split **proportionally** to stake among all synchronized nodes
- The node that forges the block receives **+10% bonus** on its share
- Nodes not synchronized at the time receive **nothing**

### Additional Rules:
- Rewards do **not automatically enter staking**
- Nodes must sell **at least 50% of their reward on the DEX** to stay eligible
- If a node generates 10 blocks within the last 2880 blocks, it is excluded for 2880 blocks
- A minimum stake threshold applies and increases every 2880 blocks (+0.0567%)
- Failure to meet daily stake quota results in progressive penalty (−0.0567%, −0.1134%, etc.) deducted from reward
- The penalty difference is assigned to the block forger

---

## 💧 DEX & Invisible Liquidity

- Every 2880 blocks, NEU are minted = 0.0567% × staking total
- Listed in DEX at +0.0567% price increase per day
- These orders **appear magically** and are not from wallets
- Validated by all clients without needing inclusion in Merkle root

---

## 📊 Reputation System

- Fully automatic and consensus-driven
- Every wallet, token, chain, node starts at 100%
- Reputations adjust based on:
  - Activity (positive actions generate votes)
  - Honest staking
  - Voting consistency
  - Error rates, invalid tx, DEX spam
- Inactivity = neutral (no penalty)
- Negative behavior triggers automatic penalties
- Recovery is possible over time through good behavior
- Fraud or bugs detected automatically can trigger reversal or state correction
- Reputation is stored as non-removable percentage visible in all interfaces

---

## 🧪 Local Test Mode: `localmain`

- Simulated local blockchain with 10 wallets
- Perfect for testing syncing, rewards, and consensus
- Includes Merkle state, staking, DEX, smallchains — all offline
- Can simulate node desync and recovery logic

---

## 🔧 Modules Overview

### `/src/core/`
- `mainchain_init.S` — Boot logic
- `block_format.S` — Block structure and rewards
- `address_encode.S` — Base32 address logic
- `constants.S` — Chain-wide parameters

### `/src/modules/`
- `object_create.S` — Create token, chain, smallchain
- `object_transfer.S` — Transfer handler
- `object_registry.S` — Registry for chain/token
- `object_properties.S` — Flags and features (mintable, dex_enabled...)
- `staking_main.S` — Staking rewards and consensus logic
- `fee_logic.S` — Custom fee structure for token-specific fees
- `dex_logic.S` — Base DEX matching
- `dex_liquidity_mint.S` — Magical DEX liquidity injection
- `vote_reputation.S` — Event-based reputation updates
- `auto_reputation.S` — Full auto reputation engine
- `marketplace_store.S`, `royalty_logic.S` — NFT/digital asset sales
- `pruning.S`, `merkle_storage.S` — Storage and cleanup

### `/src/fees/`
- `fees.S` — Global fee logic for all operations (chain creation, token issue, transfers, voting, DEX, etc.)

### `/src/custom/`
- `loader.S`, `verifier.S` — Allow smallchains to register and expose personal logic
- All user code is seen on the network as `00_00_OBJ_...`

### `/webapp/`
- `index.html` — Browser wallet/DEX frontend
- `wallet.js`, `wasm_loader.js`, `style.css`

---

## 📜 License

MIT — free to use, modify, extend or fork.

---

## 🙌 Contribute

- Check `docs/specs.md`
- Fork and clone
- Run `./tools/wasm_builder.sh`
- Edit `.S` modules and rebuild

Pull requests are welcome!


