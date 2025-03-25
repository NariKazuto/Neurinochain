;
; object_properties.S — Bitwise Flags for Configurable Object Features
; ---------------------------------------------------------------------
; This module defines and checks the bitmask flags applied to blockchain objects.
; Flags define behaviors like:
;  - Divisible, Burnable, Mintable, Transferable
;  - Chain-enabled, Whitelist-only, Pausable
;  - DEX visibility, Snapshot support, Module-extensible
;
; Used by object_create.S, object_transfer.S, etc.
;

.section .data
.global OBJECT_FLAG_DIVISIBLE
.global OBJECT_FLAG_BURNABLE
.global OBJECT_FLAG_MINTABLE
.global OBJECT_FLAG_TRANSFERABLE
.global OBJECT_FLAG_CHAIN_ENABLED
.global OBJECT_FLAG_WHITELIST_ONLY
.global OBJECT_FLAG_PAUSABLE
.global OBJECT_FLAG_DEX_VISIBLE
.global OBJECT_FLAG_SNAPSHOT_ENABLED
.global OBJECT_FLAG_EXTENSIBLE

OBJECT_FLAG_DIVISIBLE          = 0x01
OBJECT_FLAG_BURNABLE           = 0x02
OBJECT_FLAG_MINTABLE           = 0x04
OBJECT_FLAG_TRANSFERABLE       = 0x08
OBJECT_FLAG_CHAIN_ENABLED      = 0x10
OBJECT_FLAG_WHITELIST_ONLY     = 0x20
OBJECT_FLAG_PAUSABLE           = 0x40
OBJECT_FLAG_DEX_VISIBLE        = 0x80
OBJECT_FLAG_SNAPSHOT_ENABLED   = 0x100
OBJECT_FLAG_EXTENSIBLE         = 0x200


.section .text
.global _check_object_flag

_check_object_flag:
    ; Input: r0 = flagset, r1 = flag_to_check
    ; Output: r0 = 1 if present, 0 otherwise
    and r0, r0, r1
    cmp r0, #0
    moveq r0, #0
    movne r0, #1
    ret
