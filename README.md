<img src="https://raw.githubusercontent.com/NariKazuto/Neurinochain/main/neulogo256.png" alt="Neurinochain logo" width="128" />

# 🧠 Neurinochain

**Neurinochain** is a modular blockchain optimized for low-powered hardware, slow networks, and fully text-based interfaces. Written entirely in Assembly, it runs without installation via terminal (Linux or Termux on Android), designed for real-world decentralization — not just theoretical.

---

## 🌍 Our Mission: Financial Access for All

Neurinochain exists to serve users in:

- Regions without reliable banking
- Areas with slow or intermittent internet
- Devices with minimal specs (Android Go, Raspberry Pi, etc.)

> We believe blockchain must run anywhere, on anything.

---

## 🚀 Core Features

- **Terminal-First Design**: No browser needed — works in text mode
- **Stateless**: Transactions self-delete after confirmation (no database)
- **Modular Architecture**: Chains = tokens with enhanced features
- **CLI Wallet & Explorer**: Interact fully via keyboard or touchscreen
- **Invisible Rewards**: Staking appears magically in balance
- **Low Resource Usage**: Under 5 MB RAM for 3000 tx/block
- **Reputation System**: Built-in wallet/node scoring
- **Offline Support**: Bluetooth sync, air-gapped transfers

---

## 📿 How It Works

- 🧱 Blocks every 30 seconds
- 💸 Fees: 0.00008% of transfer
- ⚡️ 3000 tx/block (configurable)
- 🔐 Ed25519 signatures + SHA-256 headers
- ♻️ Merkle root saved, all tx deleted after 6 confirmations

---

## 🧠 What You Need

**Minimum (basic participation):**
- CPU: 1.5 GHz (dual-core)
- RAM: 1 GB DDR2
- Storage: 500 MB free (eMMC/SSD preferred)
- Network: 1 Mbps

**Recommended (full node, 3000 tx/block):**
- CPU: 2.4 GHz quad-core
- RAM: 2 GB+
- Storage: SSD 2 GB+
- Network: 10 Mbps down / 5 Mbps up

> Runs flawlessly on old PCs, Raspberry Pi, and Android (via Termux).

---

## 📟 Interface (CLI Only)

No web interface. Just fast, intuitive terminal navigation.

- `wallet_cli.S`: send, receive, check balance
- `explorer_cli.S`: view blocks, tx, forgers, rewards

Works with ⌨️ keyboard or 📱 touchscreen (Termux)

Navigable menu: `[↑]` `[↓]` `[Enter]` `[Q]` — 100% accessible

---

## 🧪 Local Testing

Try Neurinochain offline via `localmain` mode:

- Simulates full chain with 10 wallets
- Staking, syncing, forging, rewards
- Great for development and education

---

## 📜 License

Open-source under MIT. Fork, improve, translate, localize.

---

## 🤝 Contribute

We welcome:

- Assembly devs
- Terminal UI designers
- Optimizers for low-end hardware
- Contributors from low-bandwidth regions

> Start in `/cli/`, test with `localmain`, and push improvements.

Together, let’s make blockchain actually usable — not just for the privileged few.

