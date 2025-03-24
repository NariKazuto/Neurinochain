; --------------------------------------------
; File: /src/core/constants.S
; Description: Global constants for Neurinochain
; Author: Neurinochain Project
; --------------------------------------------

.section .data

; === Decimal Precision ===
.global DECIMALS
DECIMALS:              .word 18       ; 18 decimals like Ethereum

; === Default Fee System ===
.global BASE_FEE
.global REPUTATION_VOTE_FEE
.global DEX_FEE_PERCENT

BASE_FEE:              .word 10000000       ; 0.01 NEU
REPUTATION_VOTE_FEE:   .word 100            ; 0.00000100 NEU
DEX_FEE_PERCENT:       .word 30             ; 0.3% (30 / 10000)

; === Reputation System ===
.global MAX_REPUTATION_SCORE
MAX_REPUTATION_SCORE:  .word 10000          ; Max reputation

; === Block Timing ===
.global DEFAULT_BLOCK_TIME
DEFAULT_BLOCK_TIME:    .word 30             ; Seconds per block (mainchain)

; === Token Property Flags (bitwise) ===
.global FLAG_DIVISIBLE
.global FLAG_BURNABLE
.global FLAG_MINTABLE
.global FLAG_TRANSFERABLE
.global FLAG_CHAIN_ENABLED

FLAG_DIVISIBLE:        .word 0x01     ; Can be fractional (uses DECIMALS)
FLAG_BURNABLE:         .word 0x02     ; Can be burned
FLAG_MINTABLE:         .word 0x04     ; Can mint more supply
FLAG_TRANSFERABLE:     .word 0x08     ; Can be transferred
FLAG_CHAIN_ENABLED:    .word 0x10     ; Acts as a smallchain

; === Reserved IDs ===
.global CHAIN_ID_MAIN
.global CHAIN_ID_SYSTEM
.global TOKEN_ID_NEUR
.global OBJECT_ID_REPUTATION_MODULE

CHAIN_ID_MAIN:         .word 0x00     ; Mainchain
CHAIN_ID_SYSTEM:       .word 0xFF     ; Reserved for system-level modules

TOKEN_ID_NEUR:         .word 0x00     ; Main NEUR token
OBJECT_ID_REPUTATION_MODULE: .word 0xF0  ; Reputation system module

; === Error Codes ===
.global ERR_INVALID_SIGNATURE
.global ERR_UNAUTHORIZED
.global ERR_OBJECT_NOT_FOUND
.global ERR_INVALID_FLAGS
.global ERR_INSUFFICIENT_FUNDS

ERR_INVALID_SIGNATURE:     .word 0x01
ERR_UNAUTHORIZED:          .word 0x02
ERR_OBJECT_NOT_FOUND:      .word 0x03
ERR_INVALID_FLAGS:         .word 0x04
ERR_INSUFFICIENT_FUNDS:    .word 0x05

; === Limits ===
.global MAX_TX_SIZE
.global MAX_TOKEN_SUPPLY
.global MAX_CHAIN_DEPTH
.global MAX_OBJECTS_PER_CHAIN

MAX_TX_SIZE:               .word 1024         ; bytes
MAX_TOKEN_SUPPLY:          .word 0xFFFFFFFF   ; 4.2B max for lightweight chains
MAX_CHAIN_DEPTH:           .word 5            ; Max nested chains (future)
MAX_OBJECTS_PER_CHAIN:     .word 65536        ; Max 2^16 per chain
