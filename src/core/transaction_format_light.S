;
; transaction_format_light.S — Minimal Transaction Format for Light Clients
; -------------------------------------------------------------------------
; This module defines the compact TX format used for browser-based and Tor clients.
; Keeps fields minimal, verifies only essentials.
;
; Format:
;  - from_address (Base32)
;  - to_address (Base32)
;  - object_id (token/smallchain)
;  - amount
;  - fee
;  - nonce
;  - signature (Ed25519)
;
; Signature covers all fields.
;

.section .text
.global _tx_light_verify

_tx_light_verify:

    ; Input: pointer to tx struct
    ; Output: 1 = valid, 0 = invalid

    ; TODO: load sender, recipient, object_id, amount, fee, nonce, sig
    ; TODO: verify signature using Ed25519 (ed25519_verify)
    ; TODO: check minimum fee using fee_logic.S
    ; TODO: optional: verify against replay (nonce)

    ret
