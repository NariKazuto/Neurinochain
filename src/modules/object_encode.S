; object_encode.S — Build ENCODED_BODY from Object Parameters
; -------------------------------------------------------------
; This module takes object parameters and encodes them into the final
; blockchain identifier (ENCODED_BODY), used across all chains.
;
; Steps:
;   1. Compose binary structure:
;        [chain_id(2)] [object_id(2)] [type_id(2)] [payload/hash...]
;   2. Compute SHA-512 hash of entire buffer
;   3. Encode result in Base32
;
; Output: r0 = pointer to final ENCODED_BODY (Base32 string)
;
; Notes:
; - Called by object_create.S, keygen tools, NFT builder, etc.
; - Output must be deterministic: same input → same ENCODED_BODY
;

.section .text
.global _object_encode

_object_encode:

    ; Input:
    ;   r1 = chain_id (16-bit)
    ;   r2 = object_id (16-bit)
    ;   r3 = type_id (16-bit)
    ;   r4 = pointer to payload (hash or data)
    ;   r5 = payload length (bytes)

    ; Output:
    ;   r0 = pointer to Base32 encoded ID (ENCODED_BODY)

    ; -----------------------------------------
    ; 1. Build input buffer
    ; -----------------------------------------
    ; Buffer layout: [chain_id | object_id | type_id | payload...]
    ; Total length = 6 + payload size

    ; TODO: allocate temporary buffer
    ; TODO: store chain_id, object_id, type_id
    ; TODO: copy payload after header


    ; -----------------------------------------
    ; 2. Hash with SHA-512
    ; -----------------------------------------
    ; TODO: call sha512(buffer, total_len)


    ; -----------------------------------------
    ; 3. Encode in Base32
    ; -----------------------------------------
    ; TODO: call base32_encode(sha512_output)
    ; Store result in memory and return pointer in r0


    ; -----------------------------------------
    ; Done
    ret
