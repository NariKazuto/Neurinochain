# 🔧 Neurinochain Technical Documentation

This technical documentation provides a detailed breakdown of the file structure, folder hierarchy, and specific file extensions utilized by the Neurinochain blockchain.

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
│   │   └── merkle_storage.S
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

| Extension | Description | Purpose |
|-----------|-------------|---------|
| `.S` | Assembly source files | Core logic, crypto algorithms, module implementations |
| `.html` | HyperText Markup Language | Browser UI interface |
| `.js` | JavaScript | WASM loader, wallet logic |
| `.css` | Cascading Style Sheets | Webapp styling |
| `.wasm` | WebAssembly Binary | Compiled Assembly modules for browser execution |
| `.svg`, `.png` | Images and icons | UI logos for chains, tokens, and objects |
| `.md` | Markdown Documentation | Guides, technical specs |
| `.sh` | Shell scripts | Tools, builders, dev utilities |

---

## ⚙️ Folder Usage Explained

- **`src/core/`**: Core blockchain initialization, address encoding, and block structure logic.
- **`src/modules/`**: Token and chain logic, DEX, staking, transfers, reputation, marketplace, pruning, and storage management.
- **`src/crypto/`**: Cryptographic operations, digital signatures, hashing.
- **`src/fees/`**: Global fee definitions.
- **`src/custom/`**: Future extensibility for custom smallchain modules.
- **`wasm/`**: Compiled modules in WebAssembly format for browser execution.
- **`webapp/`**: Front-end client wallet and DEX running entirely in browser.
- **`tools/`**: Development utilities for compiling, testing, key generation.
- **`docs/`**: Technical specifications, user and developer guides.

---

## 🔑 Key Assembly Files & Their Roles

- **`mainchain_init.S`**: Boot and initial blockchain state.
- **`block_format.S`**: Block data structure and reward calculation.
- **`address_encode.S`**: ID encoding/decoding (Base32).
- **`object_create.S`**: Token, NFT, and smallchain creation logic.
- **`staking_main.S`**: Staking rewards and consensus mechanism.
- **`dex_logic.S` & `dex_liquidity_mint.S`**: Decentralized exchange core and liquidity mechanisms.
- **`vote_reputation.S` & `auto_reputation.S`**: Reputation scoring and updating.

---

## 🚀 Compiling & Running Neurinochain

To compile WebAssembly modules:

```bash
cd neurinochain/tools
./wasm_builder.sh
```

Open `webapp/index.html` in your browser to interact directly with Neurinochain.

---

## 📚 Contributing

- Fork and clone this repository.
- Make changes to `.S` Assembly modules.
- Test locally using `localmain` mode.
- Submit pull requests clearly documenting changes.

Contributions are encouraged to expand accessibility and optimize performance for low-powered devices.

