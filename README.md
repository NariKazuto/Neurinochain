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

:
