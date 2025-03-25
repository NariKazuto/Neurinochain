;
; staking_main.S — Mainchain Staking and Consensus Logic
; --------------------------------------------------------
; This module handles block forger selection, reward distribution,
; penalty enforcement, and staking difficulty on the mainchain.
;
; All NEU values are assumed to be in smallest denomination (10^18)
;

.section .text
.global _staking_main

_staking_main:

    ; -----------------------------------------
    ; 1. Check if current node is eligible
    ; -----------------------------------------
    bl get_current_node_stake         ; → r0 = stake (NEU 10^18)
    bl get_current_node_sync_flag     ; → r1 = 1 if synced, 0 if not
    bl get_dynamic_minimum_stake      ; → r2 = minimum stake (NEU)

    cmp r1, #0
    beq skip_forging                  ; not synced

    cmp r0, r2
    blt skip_forging                  ; not enough stake

    bl check_forging_limit            ; if node exceeded 10/2880 → skip
    cmp r0, #0
    beq skip_forging

    ; -----------------------------------------
    ; 2. Select eligible forger
    ; -----------------------------------------
    bl select_highest_stake_synced_node   ; r0 = address
    mov r8, r0                            ; save forger address

    bl is_another_synced_node_waiting
    cmp r0, #1
    beq pass_turn_to_next

    ; -----------------------------------------
    ; 3. Distribute block reward (10 NEU + fee)
    ; -----------------------------------------
    bl get_total_synced_stake      ; r0 = total_stake
    mov r9, r0

    mov r0, #0                     ; index = 0
reward_loop:
    bl get_node_stake_by_index       ; r1 = stake
    bl get_node_sync_flag_by_index   ; r2 = 1/0
    cmp r2, #0
    beq skip_this_node

    mul r3, r1, #1000000
    udiv r3, r3, r9

    bl is_index_forger
    cmp r0, r8
    bne apply_share

    mul r3, r3, #110
    udiv r3, r3, #100

apply_share:
    mov r4, #10000000000000000000     ; 10 NEU
    mul r5, r3, r4
    udiv r5, r5, #1000000

    bl credit_node_reward

skip_this_node:
    add r0, r0, #1
    cmp r0, #100     ; assuming 100 nodes max
    blt reward_loop

    ; -----------------------------------------
    ; 4. Penalty logic
    ; -----------------------------------------
    bl check_node_forged_10_blocks
    cmp r0, #1
    beq add_exclusion_2880_blocks

    bl check_minimum_stake_quota
    cmp r0, #0
    beq apply_penalty_to_share

    ; -----------------------------------------
    ; 5. Write result to block state
    ; -----------------------------------------
    mov r0, r8
    bl set_block_forger_metadata
    bl commit_reward_balances

skip_forging:
    ret
