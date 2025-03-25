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
    ; - Must be synchronized
    ; - Must have stake >= minimum_stake
    ; - Must not be in exclusion window (past 2880 blocks)

    ; TODO: load node state, sync flag, stake balance
    ; TODO: compare with minimum stake (dynamic)

    ; -----------------------------------------
    ; 2. Select eligible forger
    ; -----------------------------------------
    ; - Highest stake among synced nodes
    ; - If current node finished block and another synced exists → cede
    ; - If current node desyncs → next available node takes over

    ; TODO: loop through candidate list, get synced + stake
    ; TODO: choose highest stake (or first synced if fallback)

    ; -----------------------------------------
    ; 3. Distribute block reward (10 NEU + fee)
    ; -----------------------------------------
    ; - Use proportional split to active stakers
    ; - Forger gets +10% extra on its share
    ; - Nodes not synced = excluded

    ; TODO: load total active stake
    ; TODO: for each participant:
    ;         - base_share = (stake / total_stake)
    ;         - if forger: base_share *= 1.1
    ; TODO: sum shares, write to balance table

    ; -----------------------------------------
    ; 4. Penalty logic
    ; -----------------------------------------
    ; - If node forged 10 blocks in last 2880 → skip 2880 blocks
    ; - If node misses minimum daily quota → -0.0567% penalty
    ;     (given to forger of the current block)

    ; TODO: check history of forging per node
    ; TODO: apply penalty if needed

    ; -----------------------------------------
    ; 5. Write result to block state
    ; -----------------------------------------
    ; - Block creator = forger
    ; - Rewards = not stored as tx but in state
    ; - Merkle root excludes reward logic

    ; TODO: update forger address in block metadata
    ; TODO: commit updated balances
    ; TODO: skip reward tx in Merkle calc

    ; -----------------------------------------
    ; Done
    ret
