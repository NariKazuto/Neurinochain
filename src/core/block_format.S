;
; block_format.S — Mainchain Block Structure Definition
; -----------------------------------------------------
; Defines how blocks are structured in Neurinochain mainchain.
; Includes metadata, reward structure, and Merkle exclusions.
;
; This structure is used to validate, store and propagate blocks
; without relying on traditional transaction logs for rewards.
;

.section .text
.global _block_format

_block_format:

    ; -----------------------------------------
    ; Block Header
    ; -----------------------------------------
    ; - timestamp (u64)
    ; - previous_block_hash (sha512)
    ; - merkle_root (of normal transactions only)
    ; - forger_public_key (32 bytes)
    ; - block_signature (Ed25519)

    ; TODO: Define memory layout for the fields
    ; TODO: Set pointer offsets for validation & serialization


    ; -----------------------------------------
    ; Special Fields (Not in Merkle Root)
    ; -----------------------------------------
    ; These values are computed outside of the tx list.
    ; They are used by staking_main.S and dex_liquidity_mint.S

    ; reward_neu: 10 NEU created magically (not via tx)
    ; reward_fee_total: all fees in this block

    ; These are committed in block metadata, but NOT part of Merkle root

    ; TODO: memory address or offset for reward_neu
    ; TODO: memory address or offset for reward_fee_total


    ; -----------------------------------------
    ; Write Format to Block
    ; -----------------------------------------

    ; TODO: implement logic to store block with above fields
    ; TODO: support WASM decoding for browser-side verification

    ; Return (for now, placeholder)
    ret
