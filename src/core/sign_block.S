; sign_block.S - Signs a block using Ed25519

; Input:
; RDI = pointer to block_buffer (without signature)
; RSI = length of data to sign (usually fixed_header + compressed tx)
; RDX = pointer to private key (32 bytes)
; RCX = pointer to output buffer (64 bytes signature)

; Requires:
; - ed25519_sign.S must provide `ed25519_sign` function

.global sign_block

sign_block:
    ; Call ed25519_sign(buffer, length, privkey, out_signature)
    push    rdi     ; block_buffer
    push    rsi     ; length
    push    rdx     ; private_key
    push    rcx     ; signature output

    call    ed25519_sign

    ; Restore stack and return
    add     rsp, 32
    ret
