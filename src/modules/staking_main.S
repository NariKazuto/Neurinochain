reward_loop:
    bl get_node_stake_by_index       ; r1 = stake
    bl get_node_sync_flag_by_index   ; r2 = 1/0
    cmp r2, #0
    beq skip_this_node

    ; Get current dynamic minimum stake
    bl get_dynamic_minimum_stake     ; r6 = stake_min

    ; Compare r1 (stake) vs r6 (minimum stake)
    cmp r1, r6
    bge calculate_share              ; no penalty needed

    ; ---------------------------
    ; Apply progressive penalty
    ; ---------------------------

    ; Get how many blocks since node was last above threshold
    ; → returns days_penalized = floor((current_height - last_ok_block) / 2880)
    bl get_penalty_duration_for_node   ; r7 = number of periods penalized

    ; Base = 0.0567% = 567 / 1,000,000
    ; penalty_factor = (1 - 0.000567)^r7
    ; Approximated with integer logic:
    ; multiplier = (1000000 - 567)^r7

    ; Let's assume 1-day penalty: 999433
    ; If r7 = 0 → multiplier = 1000000
    ; r3 = raw share (proportional)

    mov r10, #1000000
    mov r11, #567
    sub r12, r10, r11           ; r12 = 999433

    ; raise to power r7 (simplified loop)
    mov r13, #1                 ; multiplier = 1
penalty_loop:
    cmp r7, #0
    beq end_penalty_loop
    mul r13, r13, r12
    udiv r13, r13, r10          ; normalize
    sub r7, r7, #1
    b penalty_loop
end_penalty_loop:

    ; Now apply penalty to base share
    mul r3, r3, r13
    udiv r3, r3, r10            ; penalized share now in r3

    ; Store penalty difference to give to forger
    ; penalty_diff = original_share - penalized_share
    mov r14, r3
    ; We must subtract from original (recalculate unpenalized r3)
    mul r15, r1, #1000000
    udiv r15, r15, r9
    sub r16, r15, r14           ; r16 = penalty_diff share units

    ; Convert penalty_diff to actual NEU value
    mov r4, #10000000000000000000     ; 10 NEU
    mul r17, r16, r4
    udiv r17, r17, #1000000

    ; Add to forger's pending bonus
    bl credit_forger_penalty_bonus    ; r17 = NEU to credit

calculate_share:
    ; Normal share logic continues here
