;
; dex_liquidity_mint.S — Mint Extra NEU for DEX (Every 2880 Blocks)
; -------------------------------------------------------------------
; - Triggered once every 2880 blocks
; - Mints (0.0567% × N days) of total NEU in staking
; - Adds them directly to DEX as sellable liquidity
; - Sells at price +N×0.0567% over current market price
;
; This is an invisible mint: not in Merkle root, no tx is signed.
; It appears only in DEX state and is enforced by consensus.
;
; ✅ These offers appear automatically in the DEX UI
;    - Calculated deterministically from current block height and staking total
;    - Not stored as transactions
;    - Not owned by any wallet
;    - Validated locally in WASM/Browser/Tor
;

.section .text
.global _dex_liquidity_mint

_dex_liquidity_mint:

    ; --------------------------------------------------
    ; 1. Check if current block height is multiple of 2880
    ; --------------------------------------------------
    bl get_current_block_height    ; → r0 = height
    mov r1, #2880
    udiv r2, r0, r1
    mul r2, r2, r1
    cmp r2, r0
    bne done                      ; not the right block → skip

    ; Get how many 2880-block periods have passed since genesis
    udiv r3, r0, r1               ; r3 = period_index (1, 2, 3...)

    ; --------------------------------------------------
    ; 2. Load total NEU in staking
    ; --------------------------------------------------
    bl get_total_staked_neu       ; → r4 = total_stake

    ; --------------------------------------------------
    ; 3. Calculate minted NEU = total_stake × (base × period_index)
    ;     base = 0.0567% = 567 / 1_000_000
    ;     multiplier = 567 × period_index
    ; --------------------------------------------------
    mov r5, #567
    mul r6, r5, r3                ; r6 = adjusted_percent (multiplied)
    mul r7, r4, r6                ; r7 = temp (stake × adj%)
    mov r8, #1000000
    udiv r9, r7, r8               ; r9 = amount to mint

    ; --------------------------------------------------
    ; 4. Load current DEX price for NEU (base unit)
    ; --------------------------------------------------
    bl get_current_dex_price      ; → r10 = price

    ; --------------------------------------------------
    ; 5. Calculate sell price = price × (1 + adj%)
    ;     = price × (1 + r6 / 1_000_000)
    ; --------------------------------------------------
    add r11, r8, r6               ; r11 = 1,000,000 + adjusted percent
    mul r12, r10, r11
    udiv r13, r12, r8             ; r13 = new sell price

    ; --------------------------------------------------
    ; 6. Add r9 NEU to DEX sell order at price r13
    ; --------------------------------------------------
    bl dex_add_sell_liquidity     ; args: amount = r9, price = r13

done:
    ret


    ; Done
    ret
