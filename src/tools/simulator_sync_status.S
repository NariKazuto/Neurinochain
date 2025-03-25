;
; simulator_sync_status.S — Simulates Wallet Sync State (Localmain)
; ----------------------------------------------------------------
; Marks all wallets as synchronized initially.
; Periodically simulates sync drop for some wallets,
; requiring resync before they can forge or receive rewards.
;
; Used in conjunction with staking and block consensus modules.
;

.section .text
.global simulator_sync_status

simulator_sync_status:

    ; r0 = wallet index (0 to 99)
    mov r0, #0

mark_all_synced:
    ; Set wallet[i].sync = 1 (synced)
    ; TODO: write to state_storage: wallet[i].sync_flag = 1

    ; Optional: simulate sync drop for every 10th wallet
    ; if (i % 10 == 0) → simulate unsynced
    mov r1, r0
    mov r2, #10
    udiv r3, r1, r2   ; r3 = i / 10
    mul r3, r3, r2
    sub r4, r1, r3     ; r4 = i % 10
    cmp r4, #0
    bne skip_drop

    ; Simulate sync loss (flag = 0)
    ; TODO: write wallet[i].sync_flag = 0

skip_drop:
    ; Continue loop
    add r0, r0, #1
    cmp r0, #100
    blt mark_all_synced

    ; Done
    ret
