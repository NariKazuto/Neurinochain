# 🔧 Neurinochain Technical Documentation

This technical documentation provides a detailed breakdown of the file structure, folder hierarchy, and `.S` modules used by the Neurinochain blockchain. It is meant for developers contributing to the project or customizing the stack for deployment.

---

## 📁 Project Structure

```
Neurinochain/
├── src/
│   ├── core/
│   │   ├── mainchain_init.S
│   │   ├── block_format.S
│   │   ├── address_encode.S
│   │   └── constants.S
│   ├── modules/
│   │   ├── object_create.S
│   │   ├── object_transfer.S
│   │   ├── object_registry.S
│   │   ├── object_properties.S
│   │   ├── staking_main.S
│   │   ├── fee_logic.S
│   │   ├── dex_logic.S
│   │   ├── dex_liquidity_mint.S
│   │   ├── vote_reputation.S
│   │   ├── auto_reputation.S
│   │   ├── marketplace_store.S
│   │   ├── royalty_logic.S
│   │   ├── pruning.S
│   │   ├── merkle_storage.S
│   │   ├── offline_transfer.S
│   │   └── offline_sync.S
│   ├── crypto/
│   │   ├── ed25519.S
│   │   ├── sha512.S
│   │   ├── sha256.S
│   │   ├── keccak.S
│   │   └── field_math.S
│   ├── fees/
│   │   └── fees.S
│   └── custom/
│       └── (planned custom module loaders)
├── cli/
│   ├── wallet_cli.S
│   ├── explorer_cli.S
│   ├── tools/
│   │   ├── test_fill_buffer.sh
│   │   └── tx_inspector.sh
│   └── assets/
│       ├── chains/
│       ├── tokens/
│       └── obj/
├── docs/
│   ├── specs.md
│   └── guides/
├── build/
│   └── (compiled output)
```

---

## 📄 File Types & Extensions

| Extension | Description                | Purpose                                      |
|-----------|----------------------------|----------------------------------------------|
| `.S`      | Assembly source            | Blockchain logic, modules, cryptographic ops |
| `.sh`     | Shell script               | Build tools, CLI utilities                   |
| `.md`     | Markdown                   | Documentation and guides                     |
| `.wasm`   | WebAssembly binary         | Legacy — deprecated                          |

---

## 🔑 Core Assembly Files

### Core Initialization (`src/core/`)
- `mainchain_init.S`: Boot sequence and init
- `block_format.S`: Defines block headers and layout
- `address_encode.S`: Base32 encoding for addresses and IDs
- `constants.S`: Network parameters

### Crypto Algorithms (`src/crypto/`)
- `ed25519.S`: Digital signatures
- `sha512.S`: Hashing
- `sha256.S`: Hashing (used for block headers)
- `keccak.S`: Optional hashing for modules
- `field_math.S`: Low-level math routines

### Blockchain Modules (`src/modules/`)
- `object_create.S`: Create token/smallchain/NFT
- `object_transfer.S`: Transfer logic
- `object_registry.S`: Storage of objects
- `object_properties.S`: Token/chain config flags
- `staking_main.S`: Staking and block reward logic
- `fee_logic.S`: Fee deduction and rules
- `dex_logic.S`: Decentralized Exchange engine
- `dex_liquidity_mint.S`: Inflation/market provision
- `vote_reputation.S`: User voting system
- `auto_reputation.S`: Automated wallet scoring
- `marketplace_store.S`: On-chain item sale
- `royalty_logic.S`: Usage-based token rewards
- `pruning.S`: Auto-deletion of old chain data
- `merkle_storage.S`: Temp tx buffer (6 confirmations)
- `offline_transfer.S`: Send funds offline
- `offline_sync.S`: Sync offline wallets

### Fee Definitions (`src/fees/`)
- `fees.S`: Creation cost, fee %, delegation logic

### Custom Hooks (`src/custom/`)
- Placeholder for chain- or token-specific modules

---

## 🖥️ CLI Interface Files (`/cli/`)

- `wallet_cli.S`: User wallet (send, balance)
- `explorer_cli.S`: View chain data, tx, forger
- `tools/`: Helper scripts
  - `test_fill_buffer.sh`: Simulate TX input
  - `tx_inspector.sh`: Inspect buffer/live state
- `assets/`: Chain/token metadata for terminal UI
  - `chains/`: Friendly names, logos (text/icons)
  - `tokens/`: Token display config
  - `obj/`: Object aliases and local info

---

## 🧪 Testing Modes

- `localmain`: Simulates real network with 10 wallets
- Run staking, sync, pruning, DEX, etc. fully offline
- Compatible with CLI interface only

---

## 🧰 Build Tools

- Scripts and Makefiles will be added to `/tools/`
- WASM compilation deprecated in CLI mode

---

## 👨‍🔧 Contribution Guidelines

- Follow folder/module structure
- Use Assembly with clear comments
- Commit modular changes by function
- Write CLI-usable tools or hooks when possible

---

This documentation evolves with the project — keep it updated!
