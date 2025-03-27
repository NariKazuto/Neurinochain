;
; object_registry.S — Registry for All Created Objects
; ---------------------------------------------------
; This module maintains the list of all objects created on-chain.
;
; Each object is indexed by its ENCODED_BODY (Base32 string).
; The metadata includes:
;   - Type (token, chain, NFT...)
;   - Owner
;   - Block height
;   - Flags
;   - Supply, decimals, etc.
;
; This module will later delegate to Merkle-based storage.
;

.section .text
.global _object_registry_write
.global _object_registry_lookup
.global _object_registry_add  ; alias for write

; ----------------------------------------------------
; _object_registry_add = alias for write
; ----------------------------------------------------
_object_registry_add:
    b _object_registry_write


; ----------------------------------------------------
; _object_registry_write
; Input:
;   r0 = object_id (Base32 ENCODED_BODY)
;   r1 = pointer to metadata buffer
;   r2 = metadata length (bytes)
;
; Output:
;   none (writes to registry)
; ----------------------------------------------------
_object_registry_write:

    ; TODO: Prevent duplicate ID (lookup first)
    ; TODO: Append or insert to registry map
    ; TODO: For now, treat as append-only in memory

    ; Placeholder: write_state("registry", r0, r1..r2)

    ret


; ----------------------------------------------------
; _object_registry_lookup
; Input:
;   r0 = object_id (Base32 ENCODED_BODY)
; Output:
;   r1 = pointer to metadata buffer (or 0 if not found)
; ----------------------------------------------------
_object_registry_lookup:

    ; TODO: search registry map by key
    ; TODO: return 0 if not found, else pointer to buffer

    ; Placeholder return null
    mov r1, #0
    ret
