;
; simulator_local_wallets.S — Generates 100 Wallets for Localmain Mode
; --------------------------------------------------------------------
; Creates 100 wallets with:
;  - Keypair (placeholder / deterministic for test)
;  - Initial balance: 1000 NEU each
;  - Staking activated
;  - Synced = true (to be set in separate module)
;
; Wallets are stored in simulated local state.
;

.section .text
.global simulator_local_wallets

simulator_local_wallets:

    ; r0 = loop counter
    mov r0, #0

loop_wallet_gen:
    ; -----------------------------------------
    ; 1. Generate pseudo keypair
    ; -----------------------------------------
    ; For test purposes, we use deterministic key from counter

    ; TODO: hash(r0) → pubkey, privkey (stubbed for now)
    ; TODO: store pubkey as wallet_id (base32 encoded)


    ; -----------------------------------------
    ; 2. Assign initial balance and stake
    ; -----------------------------------------
    ; Example: 1000 NEU per wallet (10^21 units)

    ; TODO: write balance = 1000000000000000000000
    ; TODO: activate staking flag


    ; -----------------------------------------
    ; 3. Write to local state
    ; -----------------------------------------
    ; Append to simulated wallet list

    ; TODO: call state_storage or test state handler


    ; Increment loop counter
    add r0, r0, #1
    cmp r0, #100
    blt loop_wallet_gen

    ; Done
    ret
