# 🔧 Neurinochain Technical Documentation

This technical documentation provides a detailed breakdown of the file structure, folder hierarchy, and specific file extensions utilized by the Neurinochain blockchain.

---

## 📁 Project Structure
```
neurinochain/
├── docs/
│   ├── specs.md
│   └── guides/
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
│   │   ├── keccak.S
│   │   └── field_math.S
│   ├── fees/
│   │   └── fees.S
│   └── custom/
│       └── (planned custom module loaders)
├── wasm/
│   └── (Compiled WASM files)
├── webapp/
│   ├── index.html
│   ├── wallet.js
│   ├── wasm_loader.js
│   ├── style.css
│   └── assets/
│       ├── chains/
│       ├── tokens/
│       └── obj/
└── tools/
    ├── wasm_builder.sh
    ├── keygen.sh
    └── dev_tools/
```

---

## 📄 File Types & Extensions
| Extension | Description             | Purpose                                       |
|-----------|-------------------------|-----------------------------------------------|
| .S        | Assembly source files   | Core logic, crypto algorithms, module code    |
| .html     | HyperText Markup        | Browser UI interface                          |
| .js       | JavaScript              | WASM loader, wallet logic                     |
| .css      | Cascading Style Sheets  | Webapp styling                                |
| .wasm     | WebAssembly Binary      | Compiled Assembly modules for browser use     |
| .svg/.png | Images and icons        | UI logos for chains, tokens, objects          |
| .md       | Markdown Documentation  | Guides, technical specs                       |
| .sh       | Shell scripts           | Tools, builders, dev utilities                |

---

## ⚙️ Folder Usage Explained
- **src/core/**: Core blockchain logic, initialization, block definitions.
- **src/modules/**: DEX, staking, transfers, smallchains, reputation, marketplace, pruning.
- **src/crypto/**: Ed25519 signatures, SHA-512, Keccak, arithmetic.
- **src/fees/**: Configurable global fees and reward logic.
- **src/custom/**: Reserved for future smallchain extensions.
- **wasm/**: Compiled modules for WebAssembly runtime.
- **webapp/**: Wallet, DEX, and UI interface entirely in-browser.
- **tools/**: Scripts for development, compilation, testing.
- **docs/**: Markdown-based documentation and guides.

---

## 🔑 Key Assembly Files & Their Roles
- **mainchain_init.S**: Blockchain boot and genesis setup.
- **block_format.S**: Defines block structure, max tx per block (configurable), and reward formatting.
- **staking_main.S**: Handles staking rules, consensus, and distribution.
- **dex_logic.S / dex_liquidity_mint.S**: Core logic for DEX and liquidity management. Active by default on mainchain.
- **fee_logic.S / fees.S**: Calculation and enforcement of all chain-related fees.
- **vote_reputation.S / auto_reputation.S**: Trust system based on user activity.
- **offline_transfer.S / offline_sync.S**: Modules for secure offline fund exchange.
- **object_create.S**: Token, NFT, and smallchain creation logic.

---

## 🚀 Compiling & Running Neurinochain
To compile WebAssembly modules:
```bash
cd neurinochain/tools
./wasm_builder.sh
```
Then open:
```bash
webapp/index.html
```
Interact with the wallet and DEX directly in your browser.

---

## 📚 Contributing
- Fork and clone the repository.
- Make changes to `.S` modules.
- Test using `localmain` mode (simulated 10-node environment).
- Submit pull requests with clear descriptions.

**Goal:** Create accessible blockchain infrastructure that scales to slow networks and low-end devices (e.g., 1.5 GHz CPU, 1 GB RAM DDR2).
