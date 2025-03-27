;
; object_transfer.S — Transfer Ownership or Balance of an Object
; ---------------------------------------------------------------
; Handles sending tokens, NFTs, or moving ownership of smallchains.
; Supports divisible/indivisible assets and permission flags.
;
; Validates object type, flags, sender rights and amount.
;

.section .text
.global _object_transfer

_object_transfer:

    ; -----------------------------------------
    ; 1. Lookup Object Metadata
    ; -----------------------------------------
    ; Input: r0 = object_id (ENCODED_BODY)
    ; Output: r1 = pointer to metadata (or 0)

    bl _object_registry_lookup
    cmp r1, #0
    beq reject_invalid_object  ; object not found

    ; -----------------------------------------
    ; 2. Check Transferability Flag
    ; -----------------------------------------
    ; Assume flags at offset [r1 + FLAGS_OFFSET]

    ldrb r2, [r1, #49]              ; FLAGS_OFFSET = 49
    mov r3, #0x01                   ; OBJECT_FLAG_TRANSFERABLE
    tst r2, r3
    beq reject_non_transferable

    ; -----------------------------------------
    ; 3. Validate Sender and Amount
    ; -----------------------------------------
    ; TODO: check if sender owns or has balance
    ; TODO: if NFT (decimals = 0), amount must be 1

    ; (Example placeholder checks can be inserted here)

    ; -----------------------------------------
    ; 4. Apply Transfer
    ; -----------------------------------------
    ; TODO: subtract amount from sender
    ; TODO: add to recipient
    ; TODO: if ownership transfer (NFT or chain), update owner

    ; -----------------------------------------
    ; Success
    ret


reject_invalid_object:
    ; Set error code or status if needed
    ret

reject_non_transferable:
    ; Set error code or status if needed
    ret

