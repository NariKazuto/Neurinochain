;
; dex_logic.S — Decentralized Exchange Logic
; --------------------------------------------
; Handles listing, matching, visibility, and liquidity
; Applies to all tokens across all chains and smallchains.
;
; Includes support for "invisible" system liquidity:
; - Appears automatically every 2880 blocks
; - Minted NEU based on staking total
; - Not tied to any wallet or address
; - Validated locally (deterministic and universal)
;
; These offers are NOT stored in Merkle root
; but are enforced by consensus and appear in all clients.
;

.section .text
.global _dex_logic

_dex_logic:

    ; --------------------------------------------------
    ; 1. Validate Token ID and DEX Permissions
    ; --------------------------------------------------
    ; Input: r0 = token_id (ENCODED_BODY)
    ; Output: r1 = metadata pointer or 0

    bl _object_registry_lookup
    cmp r1, #0
    beq reject_token_invalid

    ; Check if DEX is enabled (bitflag at offset 49)
    ldrb r2, [r1, #49]           ; load flags
    mov r3, #0x02                ; OBJECT_FLAG_DEX_ENABLED = 0x02
    tst r2, r3
    beq reject_dex_disabled

    ; --------------------------------------------------
    ; 2. Inject System NEU Order Every 2880 Blocks
    ; --------------------------------------------------
    ; (If token_id == NEU, and block % 2880 == 0)

    ; TODO: load block_height into r4
    ; TODO: check if r0 == NEU token_id (hardcoded)
    ; TODO: if (r4 % 2880 == 0) → inject sell offer

    ; Stub logic:
    ; cmp r4, #2880
    ; movs r5, r4
    ; udiv r6, r5, #2880
    ; mls r7, r6, #2880, r5  ; r7 = r4 % 2880
    ; cmp r7, #0
    ; bne skip_system_order

    ; TODO: calculate system quantity and price
    ; TODO: inject "invisible" order into view

skip_system_order:

    ; --------------------------------------------------
    ; 3. Process Order Normally (add, match, cancel)
    ; --------------------------------------------------

    ; TODO: parse tx data: sender, price, quantity
    ; TODO: match against existing orders
    ; TODO: update order book in state (if needed)

    ret

reject_token_invalid:
    ; Token doesn't exist
    ret

reject_dex_disabled:
    ; Token not allowed in DEX
    ret
