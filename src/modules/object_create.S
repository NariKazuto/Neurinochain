; object_create.S — Create Objects (Token, Smallchain, NFT...)
; -------------------------------------------------------------
; This module creates new blockchain objects using a shared structure.
;
; Output: an ENCODED_BODY = Base32(SHA-512 hash of parameters)
;
; Objects are categorized by internal flags:
;   - Smallchains are tokens with "chain_enabled" property
;   - NFTs are tokens with 0 decimals + unique supply
;
; Mainchain is NOT created here (predefined)
;
; Each object includes:
;   - ENCODED_BODY (Base32 of SHA-512)
;   - Type and flags (stored in metadata, not in the ID)
;   - Owner (creator wallet)
;   - Block height
;   - Optional name/logo for display (not stored on-chain)
;
; Registered in `object_registry` for consensus use.
;

.section .text
.global _object_create

_object_create:

    ; -----------------------------------------
    ; 1. Validate Creator
    ; -----------------------------------------
    ; - Must be a valid wallet with permissions
    ; - Must pay creation fee (defined in fees.S)

    ; TODO: check creator address
    ; TODO: verify signature
    ; TODO: deduct creation cost (e.g. 100 NEU)


    ; -----------------------------------------
    ; 2. Parse Object Parameters
    ; -----------------------------------------
    ; - Flags: is_smallchain, is_mintable, is_nft, etc.
    ; - Name (for UI), supply, decimals

    ; TODO: load and validate input fields

    ; Expected fields:
    ; - Name (max 30 bytes, padded or truncated)
    ; - Symbol (max 10 bytes)
    ; - Supply (8 bytes int)
    ; - Decimals (1 byte)
    ; - Infinite flag (1 byte, 0 or 1)

    ; Allocate buffer for 50 bytes (30+10+8+1+1)
    mov r7, #50
    bl malloc        ; r6 = pointer to buffer

    ; r8 = pointer to name
    ; r9 = pointer to symbol
    ; r10 = supply (int)
    ; r11 = infinite flag (0 or 1)

    ; Store name (max 30 bytes)
    ; TODO: copy 30 bytes from [r8] to [r6]

    ; Store symbol (max 10 bytes)
    ; TODO: copy 10 bytes from [r9] to [r6+30]

    ; Store supply (8 bytes)
    ; TODO: write r10 to [r6+40]

    ; Store decimals (fixed = 18)
    mov r12, #18
    strb r12, [r6, #48]

    ; Store infinite flag (r11)
    strb r11, [r6, #49]

    ; Payload is at r6, length in r7 = 50
    ; TODO: reject conflicting settings (e.g. NFT with >1 supply)


    ; -----------------------------------------
    ; 3. Encode Object ID (ENCODED_BODY)
    ; -----------------------------------------
    ; - Use object_encode.S:
    ;     Inputs:
    ;       r1 = chain_id
    ;       r2 = object_id (can be fixed or random per chain)
    ;       r3 = type_id
    ;       r4 = pointer to payload buffer (hash or metadata)
    ;       r5 = payload length
    ;     Output:
    ;       r0 = pointer to ENCODED_BODY (Base32 string)

    ; Generate temporary payload (example: name + supply + decimals)
    ; Assume these are preloaded in memory at address r6 with length r7
    ; r6 = payload pointer
    ; r7 = payload length

    mov r4, r6          ; payload pointer
    mov r5, r7          ; payload length

    ; Set example chain_id, object_id, type_id
    mov r1, #0x0000     ; chain_id = mainchain
    mov r2, #0x0100     ; object_id = 0x0100 (example value)
    mov r3, #0x0001     ; type_id = token (could vary by object type)

    bl _object_encode   ; result in r0 → ENCODED_BODY (Base32)
    ; TODO: store r0 as object ID


    ; -----------------------------------------
    ; 4. Register in object_registry
    ; -----------------------------------------
    ; - Save object metadata, flags, owner, etc.
    ; - Used for validation and UI info

    ; TODO: store object in registry


    ; -----------------------------------------
    ; Done
    ret

