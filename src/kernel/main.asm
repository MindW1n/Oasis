org 0x7e00
bits 64
[map all etc/kernelLinks.map]

section .text

_startLM:	
	;
	; Printing about switching 
	; to 64-bit success		
	;
	mov rsi, done
	call Screen._print

	;
	; Print loading IDT
	;
	mov rsi, loadingIDT
	call Screen._print

	;
	; Load IDT
	; 	
	call _loadIDT	

	;
	; Print about loading IDT success
	;	
	mov rsi, done
	call Screen._print

	call ATA._init
	call PCI._init
	jmp _chill

;
; Drivers
;
%include "src/drivers/keyboard/main.asm"
%include "src/drivers/screen/main.asm"
%include "src/drivers/PCI/main.asm"
%include "src/drivers/ATA/main.asm"

;
; Interrupt handlers
;
%include "src/interrupts/interruptServiceRoutines/DivisionBy0InterruptHandler/main.asm"
%include "src/interrupts/interruptServiceRoutines/InvalidOpcodeInterruptHandler/main.asm"
%include "src/interrupts/interruptServiceRoutines/DeviceNotAvailableInterruptHandler/main.asm"
%include "src/interrupts/interruptServiceRoutines/InvalidTSSInterruptHandler/main.asm"
%include "src/interrupts/interruptServiceRoutines/SegmentNotPresentInterruptHandler/main.asm"
%include "src/interrupts/interruptServiceRoutines/StackSegmentFaultInterruptHandler/main.asm"
%include "src/interrupts/interruptServiceRoutines/GeneralProtectionFaultInterruptHandler/main.asm"
%include "src/interrupts/interruptServiceRoutines/PageFaultInterruptHandler/main.asm"
%include "src/interrupts/interruptServiceRoutines/FloatingPointExceptionHandler/main.asm"
%include "src/interrupts/interruptServiceRoutines/KeyboardInterruptHandler/main.asm"
%include "src/interrupts/interruptServiceRoutines/ClockInterruptHandler/main.asm"
%include "src/interrupts/interruptServiceRoutines/SyscallHandler/main.asm"
%include "src/interrupts/resources/IDTInterruptGatePattern/main.asm"

;
; Syscalls
;
%include "src/syscalls/sysRead/main.asm"

;
; AsmFunctions
;
%include "../../AsmFun/Headers64bit/LoadIDT/main.asm"
%include "../../AsmFun/Headers64bit/Memcpyq/main.asm"
%include "../../AsmFun/Headers64bit/Break/main.asm"
%include "../../AsmFun/Headers64bit/HaltMachine/main.asm"
%include "../../AsmFun/Headers64bit/Chill/main.asm"
%include "../../AsmFun/Headers64bit/IntToString/main.asm"
%include "../../AsmFun/Headers64bit/AssignFlippedIntegerPortion/main.asm"
%include "../../AsmFun/Headers64bit/FlipString/main.asm"
%include "../../AsmFun/Headers64bit/Memclrb/main.asm"
%include "../../AsmFun/Headers64bit/Strcpy/main.asm"
%include "../../AsmFun/Headers64bit/Pusha/main.asm"
%include "../../AsmFun/Headers64bit/Popa/main.asm"

;
; Strings
;
done db "Done!", 10, 0
lineBreak db 10, 0
loadingIDT db "Loading IDT... ", 0
