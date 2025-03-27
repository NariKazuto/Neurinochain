📐 Neurinochain Constants Reference
This document explains the purpose of each constant defined in /src/core/constants.S.
These values control the behavior of the core blockchain logic, DEX, staking, fees, and object properties.

🧮 Decimal Precision
Constant	Value	Description
DECIMALS	18	All tokens use 10^18 units (like Ethereum)
💸 Base Fees
Constant	Value	Description
BASE_FEE	10,000,000	Default transaction fee (0.01 NEU)
REPUTATION_VOTE_FEE	100	Fee per vote in the reputation system
DEX_FEE_PERCENT	30	DEX fee = 0.3% (30 / 10000) of traded amount
📊 Reputation
Constant	Value	Description
MAX_REPUTATION_SCORE	10,000	Reputation is stored as integer 0 → 10,000
⏱️ Block Timing
Constant	Value	Description
DEFAULT_BLOCK_TIME	30	Seconds per block (mainchain)
BLOCK_INTERVAL_SYSTEM_ORDER	2880	Every 2880 blocks, DEX injects automatic NEU sell orders
🏷️ Token Flags (bitwise)
These flags define token/smallchain capabilities.

Flag Name	Bit	Description
FLAG_DIVISIBLE	0x01	Token has decimals (e.g. NEU)
FLAG_BURNABLE	0x02	Can be destroyed/burned
FLAG_MINTABLE	0x04	Can mint additional supply
FLAG_TRANSFERABLE	0x08	Can be sent to other wallets
FLAG_CHAIN_ENABLED	0x10	Acts as a smallchain
FLAG_DEX_ENABLED	0x20	Can be traded on DEX
🆔 Reserved IDs
Constant	Value	Description
CHAIN_ID_MAIN	0x00	ID of the mainchain
CHAIN_ID_SYSTEM	0xFF	System-level reserved chain
TOKEN_ID_NEUR	0x00	NEUR token is the default
OBJECT_ID_REPUTATION_MODULE	0xF0	Internal module ID for reputation
📦 Hardcoded Token ID (Optional)
Constant	Description
ENCODED_BODY_NEUR	Base32-encoded ID for NEUR token (used for DEX validation)
❌ Error Codes
Code	Constant	Description
1	ERR_INVALID_SIGNATURE	Signature is missing or bad
2	ERR_UNAUTHORIZED	Action not allowed
3	ERR_OBJECT_NOT_FOUND	Token or wallet does not exist
4	ERR_INVALID_FLAGS	Flags invalid or inconsistent
5	ERR_INSUFFICIENT_FUNDS	Not enough tokens/balance
🧱 Capacity Limits
Constant	Value	Description
MAX_TX_SIZE	1024 bytes	Max transaction payload size
MAX_TOKEN_SUPPLY	4,294,967,295	Maximum supply for any token
MAX_CHAIN_DEPTH	5	Reserved for nested smallchains
MAX_OBJECTS_PER_CHAIN	65,536	Max number of tokens per chain
🛠️ You can modify these values before compiling your WASM modules for custom chain behavior.

