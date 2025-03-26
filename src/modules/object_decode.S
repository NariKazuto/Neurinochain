; object_decode.S — Parse ENCODED_BODY to extract object data
; ------------------------------------------------------------
; This module parses a Base32-decoded ENCODED_BODY and extracts:
;   - Chain ID (2 bytes)
;   - Object ID (2 bytes)
;   - Type ID (2 bytes)
;   - Payload or hash (remaining bytes)
;
; Called when validating any object (wallet, token, smallchain, etc.)
; Used by wallets, explorers, consensus modules.
;
; Input:
;   r0 = pointer to Base32-decoded bytes (ENTIRE OBJECT BUFFER)
;
; Output:
;   r1 = chain_id
;   r2 = object_id
;   r3 = type_id
;   r4 = pointer to payload/hash body
;

.section .text
.global _object_decode

_object_decode:

    ; Load chain_id (bytes 0–1)
    ldrb r1, [r0]
    ldrb r12, [r0, #1]
    lsl r1, r1, #8
    orr r1, r1, r12

    ; Load object_id (bytes 2–3)
    ldrb r2, [r0, #2]
    ldrb r12, [r0, #3]
    lsl r2, r2, #8
    orr r2, r2, r12

    ; Load type_id (bytes 4–5)
    ldrb r3, [r0, #4]
    ldrb r12, [r0, #5]
    lsl r3, r3, #8
    orr r3, r3, r12

    ; Set pointer to payload (byte 6 onward)
    add r4, r0, #6

    bx lr
