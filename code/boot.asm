	org 0x7c00	; program address start
BaseOfStack equ 0x7c00	; assignment

Label_Start:
	mov ax, cs	; now cs=0
	mov ds, ax	; init data segment
	mov es, ax	; init Extra segment
	mov ss, ax	; init stack segment
	mov sp, BaseOfStack

; clear screen
	mov ax, 0x0600	; AH=0x06 scroll screen
	mov bx, 0x0700	; BH=color,
	mov cx, 0x0000	; CH=left top cloumn num, CL=left top line num
	mov dx, 0x184f	; DH=right down cloumn num, DL=right down line num
	int 0x0010

; set focus
	mov ax, 0x0200	; AH=Set cursor position
	mov bx, 0x0000	; BH=page num
	mov dx, 0x0000	; DH=cursor column num, DL=cursor line num
	int 0x0010

; display on screen: Start Booting...
	mov ax, 0x1301	; AH=0x13, show a line string; AL=write mode
	mov bx, 0x000f	; BH=page num; BL=char attrubute
	mov dx, 0x0000	; DH=cursor line num; DL=cursor column num
	mov cx, 0x000A	; CX=string length
	push ax
	mov ax, ds
	mov es, ax	; es:bp=string memery address
	pop ax
	mov bp, StartBootMessage	; bp=string memery address
	int 0x0010

; reset floppy
	xor ah, ah	; AH=0x00 reset drive
	xor dl, dl	; DL=drive num
	int 0x0013

	jmp $

StartBootMessage: db "Start Boot"

; fill zero until whole sector
	times 510 - ($ - $$) db 0
	dw 0xaa55
