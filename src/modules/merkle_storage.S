; merkle_storage.S — Temporary Transaction Buffer for up to 6 Confirmations
; -----------------------------------------------------
; This module allows nodes or storage smallchains to access full transaction data
; before it is discarded (after 6 confirmations).
;
; Strategy:
; - Transactions are readable after 1 confirmation
; - They must be saved before the 6th confirmation
; - Buffer is stored in RAM (volatile)
;
; Used by:
; - Explorer
; - Smallchains that archive data
; - Local tools or interfaces
;
; Notes:
; - Memory layout uses ring buffer by block height
; - Each slot can store up to MAX_TX_PER_BLOCK transactions
; - Aged-out blocks are overwritten as new ones come in

.section .bss
    ; Reserve RAM space for 6 block slots
    ; Each block can hold 3000 tx pointers (or indexes)
    ; Adjust based on architecture and MAX_TX_PER_BLOCK

    .comm tx_ring_buffer, 6 * 3000 * 8  ; 8 bytes per tx pointer
    .comm tx_ring_heights, 6 * 4        ; 4 bytes per block height

.section .text

.global _buffer_store_block_tx
_buffer_store_block_tx:
    ; Input: r0 = block_height, r1 = tx_pointer_array
    ; Purpose: Save transactions in RAM at height position

    push {r4-r7, lr}

    ; Calculate index = block_height % 6
    mov r2, #6
    udiv r3, r0, r2
    mls r4, r3, r2, r0     ; r4 = index in ring buffer

    ; Save block height to tx_ring_heights[index]
    ldr r5, =tx_ring_heights
    add r5, r5, r4, LSL #2
    str r0, [r5]

    ; Calculate pointer offset into tx_ring_buffer
    ldr r6, =tx_ring_buffer
    mov r7, #3000
    mul r4, r4, r7
    add r6, r6, r4, LSL #3     ; 8 bytes per entry

    ; Copy 3000 tx pointers from r1 to buffer slot
    mov r7, #0
.copy_loop:
    ldr r2, [r1, r7, LSL #2]
    str r2, [r6, r7, LSL #3]
    add r7, r7, #1
    cmp r7, #3000
    blt .copy_loop

    pop {r4-r7, pc}

.global _buffer_get_tx_by_height
_buffer_get_tx_by_height:
    ; Input: r0 = block_height, r1 = tx_index
    ; Output: r0 = tx_pointer or 0 if not found

    push {r4-r6, lr}

    ; Protect against out-of-bounds tx_index
    cmp r1, #3000
    bge .not_found

    ; Compute index = block_height % 6
    mov r2, #6
    udiv r3, r0, r2
    mls r4, r3, r2, r0     ; r4 = index

    ; Compare stored height
    ldr r5, =tx_ring_heights
    add r5, r5, r4, LSL #2
    ldr r6, [r5]
    cmp r6, r0
    bne .not_found

    ; Load tx pointer
    ldr r5, =tx_ring_buffer
    mov r6, #3000
    mul r4, r4, r6
    add r5, r5, r4, LSL #3
    ldr r0, [r5, r1, LSL #3]
    pop {r4-r6, pc}

.not_found:
    mov r0, #0
    pop {r4-r6, pc}

.global _buffer_get_block_tx_array
_buffer_get_block_tx_array:
    ; Input: r0 = block_height
    ; Output: r0 = pointer to tx array or 0 if not found

    push {r4-r6, lr}

    ; Compute index = block_height % 6
    mov r2, #6
    udiv r3, r0, r2
    mls r4, r3, r2, r0   ; r4 = index

    ; Verify stored height
    ldr r5, =tx_ring_heights
    add r5, r5, r4, LSL #2
    ldr r6, [r5]
    cmp r6, r0
    bne .not_found_block

    ; Return pointer to tx array
    ldr r5, =tx_ring_buffer
    mov r6, #3000
    mul r4, r4, r6
    add r0, r5, r4, LSL #3
    pop {r4-r6, pc}

.not_found_block:
    mov r0, #0
    pop {r4-r6, pc}

.global _buffer_purge_oldest
_buffer_purge_oldest:
    ; This function is optional in ring buffer (auto-overwrite)
    ; No implementation needed unless cache fallback is used
    bx lr

.global _buffer_dump_to_cache
_buffer_dump_to_cache:
    ; Placeholder for optional disk fallback (/tmp or other)
    ; Save tx_ring_buffer + tx_ring_heights to file
    bx lr

.global _buffer_load_from_cache
_buffer_load_from_cache:
    ; Placeholder for optional disk recovery
    ; Load tx_ring_buffer + tx_ring_heights from file
    bx lr
