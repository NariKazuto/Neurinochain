;
; object_create.S — Create Objects (Mainchain, Token, Smallchain, NFT...)
; ------------------------------------------------------------------------
; This module creates new blockchain objects with a shared structure.
; Each object has:
;  - Base32 ID (SHA-512 hash of contents)
;  - Type: mainchain, token, smallchain, NFT
;  - Optional properties (bitwise)
;  - Owner, creation block, initial supply
;
; The object is registered in `object_registry`.
;

.section .text
.global _object_create

_object_create:

    ; -----------------------------------------
    ; 1. Validate Creator
    ; -----------------------------------------
    ; - Must be a valid wallet with permissions
    ; - Must pay creation fee (if enforced)

    ; TODO: check creator address
    ; TODO: verify signature
    ; TODO: deduct creation cost (ex: 100 NEU)


    ; -----------------------------------------
    ; 2. Parse Object Type + Params
    ; -----------------------------------------
    ; - Type: 0 = mainchain, 1 = token, 2 = smallchain, 3 = NFT
    ; - Name, supply, decimals, properties (bitflags)

    ; TODO: load and validate input fields
    ; TODO: reject if type already exists (ex: second mainchain)


    ; -----------------------------------------
    ; 3. Compute Object ID (Base32)
    ; -----------------------------------------
    ; - SHA-512 hash of all parameters
    ; - Encode in Base32

    ; TODO: prepare input buffer
    ; TODO: call sha512 -> base32 encoder


    ; -----------------------------------------
    ; 4. Register in object_registry
    ; -----------------------------------------
    ; - Save to block state as new entry
    ; - Includes metadata + properties + creation block

    ; TODO: write full object struct to registry


    ; -----------------------------------------
    ; Done
    ret
