;
; localmain_start.S — Local Simulation Bootstrap (100 Wallet Test Network)
; ------------------------------------------------------------------------
; Starts the Neurinochain in "localmain" mode.
; Simulates 100 wallet nodes with staking, sync and block generation.
; All logic runs offline, ideal for testing modules and consensus behavior.
;
; Files required: simulator_local_wallets.S, simulator_cycle_blocks.S, simulator_sync_status.S
;

.section .text
.global _localmain_start

_localmain_start:

    ; -----------------------------------------
    ; 1. Initialize Wallets
    ; -----------------------------------------
    ; Create 100 wallets with stake, balances, keys
    ; Each wallet is added to the local state

    bl simulator_local_wallets

    ; -----------------------------------------
    ; 2. Mark All Nodes as Synchronized
    ; -----------------------------------------
    ; This enables staking to proceed immediately

    bl simulator_sync_status

    ; -----------------------------------------
    ; 3. Start Block Generation Cycle
    ; -----------------------------------------
    ; Run simulated staking, block rewards, penalties
    ; Loop or generate N blocks for debugging

    bl simulator_cycle_blocks

    ; Done
    ret
