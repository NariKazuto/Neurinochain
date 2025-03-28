; staking_main.S - Mainchain Staking and Block Rewards
; ======================================================
; Handles staking eligibility, reward distribution, and staking difficulty growth.
; This module runs only on the mainchain.

; Constants
INITIAL_MIN_STAKE       equ 1000000000000000000   ; 1 NEU in atomic units (10^18)
STAKING_GROWTH_RATE     equ 1                     ; Placeholder, real growth via pow()
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
    ; Pseudo-code logic:
    ; 1. Load current minimum stake
    ; 2. For each staker:
    ;    - If stake >= minimum:
    ;        reward_share = stake / total_stake
    ;    - Else:
    ;        reward_share = stake / total_stake * reduction_factor
    ; 3. Sum all real_reward_shares
    ; 4. Assign base rewards (STANDARD_REWARD + total_fee_collected)
    ; 5. Calculate unclaimed portion
    ; 6. Forger gets +10% of their share + unclaimed
    ; 7. Write amounts to spendable balances (not staked)
    ; TODO: Implement real loop over staking pool
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
