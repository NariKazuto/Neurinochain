; --------------------------------------------
; File: /src/core/constants.S
; Description: Global constants for Neurinochain
; Author: Union of the human intellect
; --------------------------------------------

.section .data

; === Decimal Precision (for all tokens) ===
.global DECIMALS
DECIMALS:              .word 18       ; 18 decimals (1 NEU = 10^18 units)

; === Reputation System Parameters (automatic, 0–100%) ===
.global REPUTATION_MAX
.global REPUTATION_DEFAULT
REPUTATION_MAX:        .word 100            ; Max reputation = 100%
REPUTATION_DEFAULT:    .word 100            ; Default starting reputation = 100%

; === Block Timing and Intervals ===
.global DEFAULT_BLOCK_TIME                  ; Time between blocks
DEFAULT_BLOCK_TIME:    .word 30             ; 30 seconds per block (mainchain)

.global BLOCK_INTERVAL_SYSTEM_ORDER         ; Interval for system NEU injection
BLOCK_INTERVAL_SYSTEM_ORDER: .word 2880     ; Every 2880 blocks (≈1 day)

; === Token Property Flags (bitwise) ===
.global FLAG_DIVISIBLE       ; Token has decimals
.global FLAG_BURNABLE        ; Token can be burned
.global FLAG_MINTABLE        ; Token can be minted
.global FLAG_TRANSFERABLE    ; Token can be transferred
.global FLAG_CHAIN_ENABLED   ; Token is a smallchain
.global FLAG_DEX_ENABLED     ; Token can be traded on DEX

FLAG_DIVISIBLE:        .word 0x01     ; 1 << 0
FLAG_BURNABLE:         .word 0x02     ; 1 << 1
FLAG_MINTABLE:         .word 0x04     ; 1 << 2
FLAG_TRANSFERABLE:     .word 0x08     ; 1 << 3
FLAG_CHAIN_ENABLED:    .word 0x10     ; 1 << 4
FLAG_DEX_ENABLED:      .word 0x20     ; 1 << 5

; === Reserved IDs for core modules or system tokens ===
.global CHAIN_ID_MAIN
.global CHAIN_ID_SYSTEM
.global TOKEN_ID_NEUR
.global OBJECT_ID_REPUTATION_MODULE

CHAIN_ID_MAIN:         .word 0x00     ; ID for the mainchain
CHAIN_ID_SYSTEM:       .word 0xFF     ; Reserved for system modules
TOKEN_ID_NEUR:         .word 0x00     ; Main token (NEUR)
OBJECT_ID_REPUTATION_MODULE: .word 0xF0  ; ID for internal reputation logic

; === Optional: Hardcoded Base32 of NEUR Token ID (for DEX use) ===
.global ENCODED_BODY_NEUR
ENCODED_BODY_NEUR: .asciz "MFZXKZ3WOBSWIIDTNF2HI3DJNZTGS4TDL5XGIY3JLFBQ"

; === Error Codes (for system-level failure reporting) ===
.global ERR_INVALID_SIGNATURE
.global ERR_UNAUTHORIZED
.global ERR_OBJECT_NOT_FOUND
.global ERR_INVALID_FLAGS
.global ERR_INSUFFICIENT_FUNDS

ERR_INVALID_SIGNATURE:     .word 0x01   ; Signature invalid or missing
ERR_UNAUTHORIZED:          .word 0x02   ; Not allowed to execute
ERR_OBJECT_NOT_FOUND:      .word 0x03   ; Token or wallet doesn't exist
ERR_INVALID_FLAGS:         .word 0x04   ; Flag mismatch
ERR_INSUFFICIENT_FUNDS:    .word 0x05   ; Not enough tokens/balance

; === Limits and Capacities ===
.global MAX_TX_SIZE
.global MAX_TOKEN_SUPPLY
.global MAX_CHAIN_DEPTH
.global MAX_OBJECTS_PER_CHAIN

MAX_TX_SIZE:               .word 1024         ; Max bytes per transaction
MAX_TOKEN_SUPPLY:          .word 0xFFFFFFFF   ; Max 4.2B for lightweight tokens
MAX_CHAIN_DEPTH:           .word 5            ; Nested chains (reserved)
MAX_OBJECTS_PER_CHAIN:     .word 65536        ; 2^16 max tokens per chain
