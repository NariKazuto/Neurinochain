; staking_main.S - Mainchain Staking and Block Rewards
; ======================================================
; Handles staking eligibility, reward distribution, and staking difficulty growth.
; This module runs only on the mainchain.

; Constants
INITIAL_MIN_STAKE       equ 1000000000000000000   ; 1 NEU in atomic units (10^18)
STAKING_GROWTH_RATE     equ 1000567               ; Represents 1.000567 (scaled by 1e6)
BLOCKS_PER_DAY          equ 2880                  ; 1 day worth of blocks (30s per block)
STANDARD_REWARD         equ 10000000000000000000  ; 10 NEU per block

section .data
current_epoch_day       dq 0                      ; days since genesis
staking_minimum_current dq INITIAL_MIN_STAKE      ; updated minimum stake amount

global update_staking_minimum
; ------------------------------------------------------------------------------
; update_staking_minimum
; Updates staking_minimum_current = INITIAL_MIN_STAKE * (1.000567 ^ epoch_days)
; Input: r0 = current block height
; Output: staking_minimum_current (in memory)
; ------------------------------------------------------------------------------
update_staking_minimum:
    ; Calculate current day: epoch_days = block_height / BLOCKS_PER_DAY
    mov r1, BLOCKS_PER_DAY
    udiv r2, r0, r1
    str r2, [current_epoch_day]

    ; staking_min = INITIAL_MIN_STAKE * (1.000567 ^ epoch_days)
    ; Note: Floating point exponentiation must be simulated or precomputed
    ; TODO: Implement fixed-point pow approximation or lookup table

    ; Placeholder: keep staking_minimum_current constant for now
    mov r3, INITIAL_MIN_STAKE
    str r3, [staking_minimum_current]
    ret


; ------------------------------------------------------------------------------
; distribute_block_rewards
; Distributes rewards to active stakers and bonus to forger
; Input: r0 = forger_id, r1 = total_fee_collected, r2 = staking_pool[]
; Output: writes NEU to balances accordingly
; ------------------------------------------------------------------------------
global distribute_block_rewards
distribute_block_rewards:
    ; TODO:
    ; 1. Calculate total stake from eligible nodes
    ; 2. For each staker:
    ;    - if stake >= staking_minimum_current:
    ;        receive proportional reward
    ;    - else:
    ;        receive reduced reward by growth percentage
    ; 3. Calculate forger bonus: +10% of its eligible share + unclaimed difference
    ; 4. Add STANDARD_REWARD + r1 (fees) to total distributed
    ; 5. Write directly into spendable balances (not staking balance)
    ret


; ------------------------------------------------------------------------------
; validate_staker_eligibility
; Checks if wallet is eligible for staking based on current minimum
; Input: r0 = stake_amount
; Output: r0 = 1 if eligible, 0 if not
; ------------------------------------------------------------------------------
global validate_staker_eligibility
validate_staker_eligibility:
    ldr r1, [staking_minimum_current]
    cmp r0, r1
    movcs r0, #1     ; eligible
    movcc r0, #0     ; not eligible
    ret

    ; Normal share logic continues here
