; fees.S - Global Fee and Cost Configuration
; ==========================================
; Central module for defining:
;  - Transfer fee percent
;  - DEX fee percent
;  - Chain and token creation cost
;  - Fee update rules
;  - Delegation to Neurino nodes
;  - DB pruning after 28800 blocks
;
; Used by: fee_logic.S, dex_logic.S, object_create.S, pruning.S

; Configuration Constants
MAX_DECIMALS            equ 18             ; Maximum number of decimals
STANDARD_FEE_PERCENTAGE equ 0.0000001      ; 0.00001% expressed as decimal
DEX_FEE_PERCENT         equ 30             ; Example: 30 means 0.3%
SMALLCHAIN_CREATION_COST equ 25            ; Cost to create a smallchain (NEU)
TOKEN_CREATION_COST     equ 1              ; Cost to create a token (NEU)
FEE_UPDATE_COST         equ 10             ; Cost to update fee percentage (NEU)
DATABASE_PRUNE_BLOCKS   equ 28800          ; Blocks before database pruning

section .data
; Accumulated fee in the mainchain
mainchain_accumulated_fee dq 0

section .text

; ----------------------------------------------------------------
; _get_fee_percent
; Calculates fee = STANDARD_FEE_PERCENTAGE of transferred amount
; Input: r0 = amount
; Output: r1 = fee to pay
; ----------------------------------------------------------------
.global _get_fee_percent
_get_fee_percent:
    ; TODO: r1 = r0 * STANDARD_FEE_PERCENTAGE
    ret

; ----------------------------------------------------------------
; _get_dex_fee_percent
; Returns DEX_FEE_PERCENT from constants
; Output: r0 = percent (ex: 30 for 0.3%)
; ----------------------------------------------------------------
.global _get_dex_fee_percent
_get_dex_fee_percent:
    ldr r0, =DEX_FEE_PERCENT
    ldr r0, [r0]
    ret

; ----------------------------------------------------------------
; _get_creation_cost
; Input: r0 = type (0 = token, 1 = chain)
; Output: r1 = cost in NEU
; ----------------------------------------------------------------
.global _get_creation_cost
_get_creation_cost:
    cmp r0, #0
    moveq r1, #1000000000000000000  ; 1 NEU for token
    movne r1, #25000000000000000000 ; 25 NEU for chain
    ret

; ----------------------------------------------------------------
; _get_fee_update_cost
; Returns cost for updating the fee percentage of a chain/token
; Output: r0 = cost in NEU
; ----------------------------------------------------------------
.global _get_fee_update_cost
_get_fee_update_cost:
    mov r0, #10000000000000000000  ; 10 NEU
    ret

; ----------------------------------------------------------------
; _is_fee_owner_authorized
; Checks if wallet has at least 61% of voting weight
; Input: r0 = wallet_id, r1 = token_id
; Output: r0 = 1 if authorized, 0 otherwise
; ----------------------------------------------------------------
.global _is_fee_owner_authorized
_is_fee_owner_authorized:
    ; TODO: calculate voting share, compare to 61%
    ret

; ----------------------------------------------------------------
; _is_using_neurino_nodes
; Checks if the current smallchain is using Neurino nodes
; Input: r0 = chain_id
; Output: r0 = 1 (yes) or 0 (no)
; ----------------------------------------------------------------
.global _is_using_neurino_nodes
_is_using_neurino_nodes:
    ; TODO: check delegation flag in registry
    ret

; ----------------------------------------------------------------
; _should_purge_db
; Checks if the database should be purged after 28800 blocks
; Input: r0 = current_block_height
; Output: r0 = 1 if true, 0 otherwise
; ----------------------------------------------------------------
.global _should_purge_db
_should_purge_db:
    mov r1, #28800
    udiv r2, r0, r1
    mls r3, r2, r1, r0   ; r3 = r0 % 28800
    cmp r3, #0
    moveq r0, #1
    movne r0, #0
    ret

; Additional placeholder functions to implement:
; - accumulate_fee
; - distribute_fee
; - update_fee
; - create_smallchain
; - create_token

; All functions must be clearly documented and logically separated

