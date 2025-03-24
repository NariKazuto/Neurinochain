# 🧠 Neurinochain

**Neurinochain** is an experimental, modular blockchain fully written in **Assembly**, designed for **low-resource ha
rdware**, **slow networks**, and **ARM-based devices**. It is optimized for resilience, portability, and extensibilit
y — and avoids unnecessary complexity or external dependencies.

---

## 🌍 What is Neurinochain?

Neurinochain is built to run in the real world: from old Android phones to microcontrollers and single-board computer
s, even with unstable internet.

It introduces **Smallchains**, enhanced tokens that act as self-contained, customizable blockchains. These are create
d **without interrupting** the mainchain and can function independently, with or without global explorer/DEX integrat
ion.

Each feature of Neurinochain is implemented as a **separate Assembly module**, allowing maximum modularity, customiza
bility, and transparency.

---

## 🚀 Key Features

- 🧩 Fully modular architecture — each function is a separate `.S` file
- ⚙️ Lightweight mainchain with 10s block times (or burst mode)
- 🌱 Smallchains created like tokens, extended with logic and privacy
- 🔐 Advanced token rules (mintable, burnable, transferable, pausable…)
- ⛓️ No transaction priority based on fees — all are treated equally
- 📦 Base58 address system for wallets, tokens, and chains
- 📤 Optional IPFS or Merkle-root-based off-chain storage
- 🧠 Custom Ed25519 and SHA-512 cryptography, written in Assembly
- 🪙 18 decimals support across all tokens

---

## 🏗️ Architecture Overview

### 🔷 Mainchain

- Hosts the native token: `NEURINO (NEU)`
- Handles block creation, fees, and Smallchain registration
- Offers low overhead and high compatibility
- Keeps the system neutral and scalable
- Default block time: 10s  
  Alternate mode: up to 10 blocks/second for sync recovery

### 🟨 Smallchain

- Created like enhanced tokens, cost: `100 NEU`  
- Fully isolated logic, independent data, tokens, modules
- Optional: DEX/explorer visibility or private operation
- Modifiable with additional `100 NEU`
- Custom rules and logic loaded through modules
- Can be supported by dedicated nodes to reduce load on the mainchain

---

neurinochain/
└── src/
    ├── core/
    │   ├── sign_block.S              # Signs a block using Ed25519
    │   ├── verify_block.S            # Verifies block integrity and signature
    │   ├── transaction_format.S      # Parses and formats transaction structure
    │   ├── block_format.S            # Defines block structure and fields
    │   ├── base58_encode.S           # Encodes wallet, token, and chain addresses
    │   ├── constants.S               # Global constants (fees, flags, limits)
    │   ├── state_storage.S           # Basic key-value state management
    │   └── mainchain_init.S          # Initializes the mainchain state
    │
    ├── crypto/
    │   ├── ed25519_sign.S            # Ed25519 signing algorithm
    │   ├── ed25519_verify.S          # Ed25519 signature verification
    │   ├── scalar_mul_base.S         # Scalar multiplication with base point
    │   ├── field_add.S               # Finite field addition
    │   ├── field_sub.S               # Finite field subtraction
    │   ├── field_mul.S               # Finite field multiplication
    │   ├── field_square.S            # Finite field squaring
    │   ├── field_reduce.S            # Field reduction mod p
    │   ├── sha512.S                  # SHA-512 hashing algorithm
    │   └── keccak256.S               # (Optional) Keccak256 for interoperability
    │
    └── modules/
        ├── smallchain_create.S       # Creates a new smallchain (token-like chain)
        ├── smallchain_update.S       # Updates config of an existing smallchain
        ├── token_create.S            # Creates a new token
        ├── token_transfer.S          # Transfers token between wallets
        ├── approval_rules.S          # Handles multi-sig, quorum, and delays
        ├── commit_reveal.S           # Deterministic randomness module
        ├── pruning.S                 # Prunes data older than 5 years
        ├── merkle_storage.S          # Anchors off-chain storage with Merkle roots
        ├── dex_logic.S               # Core logic for integrated DEX (optional)
        ├── staking.S                 # Token staking (configurable per chain)
        ├── snapshot.S                # Generates state snapshot of chain or token
        ├── airdrop.S                 # Distributes tokens to holders
        ├── ownership_transfer.S      # Transfers control of token or chain
        ├── blacklist_whitelist.S     # Manages access restrictions to tokens
        └── fee_logic.S               # Custom fee rules for modules and chains

