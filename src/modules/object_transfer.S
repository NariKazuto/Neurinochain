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
    ; 1. Validate Object ID and Type
    ; -----------------------------------------
    ; - Must exist in object_registry
    ; - Must be transferable

    ; TODO: lookup object in object_registry
    ; TODO: check flag OBJECT_FLAG_TRANSFERABLE


    ; -----------------------------------------
    ; 2. Validate Sender and Amount
    ; -----------------------------------------
    ; - Sender must be owner or have enough balance
    ; - If indivisible: amount must be 1

    ; TODO: check ownership or delegated rights
    ; TODO: validate amount format (divisible vs NFT)


    ; -----------------------------------------
    ; 3. Apply Transfer
    ; -----------------------------------------
    ; - Subtract from sender
    ; - Add to recipient
    ; - If ownership transfer (chain or NFT), change owner

    ; TODO: update balances or change ownership field


    ; -----------------------------------------
    ; Done
    ret
