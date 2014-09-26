	.syntax unified
	.arch armv7-a
	.text

	.equ locked, 1
	.equ unlocked, 0

	.global lock_mutex
	.type lock_mutex, function
lock_mutex:
        @ INSERT CODE BELOW
		ldr r2 , =locked		@ load the locked value (defined in c file) to the register r2 
								@ ==> r2 means the flag or signal to indicate current situation (I'm not sure ...)
.loop:
		ldrex r1, [r0]			@ load exclusively
		cmp r1 , #unlocked
		strexeq r1 , r2 [r0]
		cmpeq r1 , #0			@ if r1 == 0 
		bne .loop				@ then execute bne .loop to .loop else to unlock_mutex
        @ END CODE INSERT
	bx lr

	.size lock_mutex, .-lock_mutex

	.global unlock_mutex
	.type unlock_mutex, function
unlock_mutex:
	@ INSERT CODE BELOW
        ldr r1 , =unlocked
		str r1 , [r0]		@ Available to store the value r1 to address r0
    @ END CODE INSERT
	bx lr
	.size unlock_mutex, .-unlock_mutex

	.end
