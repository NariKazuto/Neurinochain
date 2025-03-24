; --------------------------------------------
; File: /src/core/mainchain_init.S
; Description: Initializes the Neurinochain mainchain (genesis block)
; Author: Neurinochain Project
; --------------------------------------------

.section .text
.global mainchain_init

mainchain_init:
    ; Set default constants (can be imported from constants.S if modular)
    ; Example values: block time = 30s, chain_id = 0x00

    mov r0, #0x00              ; chain_id for mainchain
    mov r1, #0x00              ; object_id for main token (NEUR)
    mov r2, #0x00              ; initial reputation level
    mov r3, #0x1DCD6500        ; initial supply (e.g., 500_000_000 NEU, 18 decimals)

    ; Call object creation routine (token with chain features)
    ; r0 = chain_id, r1 = object_id, r3 = supply
    ; Convention: r4 = flags for token properties
    ; Flags: 0b00011111 = mintable, burnable, transferable, divisible, chain_enabled
    mov r4, #0x1F
    bl object_create_token     ; you must define this in /src/modules/object_create.S

    ; Store genesis block hash into Merkle root structure
    ; You can store Merkle root or initial state here
    bl store_genesis_merkle

    ; Return from init
    bx lr

; Helper: store_genesis_merkle (stub for now)
store_genesis_merkle:
    ; Save "GENESIS" as root node for Merkle tree (dummy for boot)
    ; Replace with actual hash computation (e.g., SHA-512 over initial state)
    mov r0, #'G'      ; placeholder
    mov r1, #'E'
    mov r2, #'N'
    mov r3, #'E'
    mov r4, #'S'
    mov r5, #'I'
    mov r6, #'S'
    ; Store to Merkle map [to be implemented in merkle_storage.S]
    ; For now, return
    bx lr
