;
; fee_logic.S — Custom Fee Logic per Transaction Type or Chain
; -------------------------------------------------------------
; This module validates that a transaction has paid an acceptable fee.
;
; Base fee thresholds are defined in `fees.S`.
; This module DOES NOT handle token-level custom fees (those belong in a separate module).
;
; Input:
;   r0 = object_id (target token or chain)
;   r1 = provided_fee (uint128)
;   r2 = tx_type       (uint8 or uint16)
;
; Output:
;   r0 = 1 if fee is valid
;   r0 = 0 if fee is rejected (too low)
;

.section .text
.global _validate_fee

_validate_fee:

    ; -----------------------------------------
    ; 1. Lookup base fee for this tx type
    ; -----------------------------------------
    ; Call into `fees.S` with tx_type → returns r3 = required_fee

    mov r0, r2          ; tx_type → r0
    bl _get_base_fee    ; returns r3 = required fee

    ; -----------------------------------------
    ; 2. Compare provided_fee (r1) >= required_fee (r3)
    ; -----------------------------------------
    cmp r1, r3
    bge fee_ok

fee_fail:
    mov r0, #0
    ret

fee_ok:
    mov r0, #1
    ret

