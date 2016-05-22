stack segment stack
	db 100 dup(?)
stack ends
data segment
 buff db 16 dup(20h),'$'
 result	dw 0							;����ת����Ķ�������
 mes1 db 0dh,0ah						;�س�����
     db 'Please enter a decimal number between 0~9999:$'	
 mes2 db 0dh,0ah						;�س�����
     db 'It corresponds to the binary number is:','$'
data ends
code segment
	assume cs:code,ds:data,ss:stack
start:	mov ax,data					;�����ݶεĶε�ַdata����ax��
	mov ds,ax					;��ax��ֵ����ds��
        lea dx,mes1					;ȡmes1��ƫ�Ƶ�ַ,����dx��
	mov ah,9
	int 21h
	lea si,result
	call input				;������Ľ��ת������Result��Ԫ
	lea dx,mes2                           	;��ʾ�����ʾ��Ϣ
	mov ah,09h
	int 21h

	mov bx,result
	lea si,buff
	call output                            	;��Result�е���ת����Ҫ��ʾ��ASCII�� 
	mov ah,09h
	lea dx,buff				;�ѽ���������ʾ����
	int 21h
	mov ax,4c00h
	int 21h
input:
	mov ah,01h				;�������벢����
	int 21h
	cmp al,0dh                            	;�������Ĳ��ǻس���������룬�����������
	jz endret
	mov ah,0
	sub al,30h                  		;����û���д��ܣ��ٶ�����ľ���0��9�����֣�����ֱ�Ӽ�30H
	push ax                                	;����AX����ʱAHҪ��0
	mov ax,[si]                            	;ת���㷨��result��result*10��AX
	mov bx,10			       	;��10����bx��
	mul bx				       	;al*bx 
	mov [si],ax
	pop ax
	add [si],ax
	jmp input
endret:
	ret
output:
 	mov cx,16
s0:
	mov dl,30h
	rol bx,1		;bxѭ������1λ,
	adc dl,0		;����λ�ӷ�ָ��
	mov [si],dl
	inc si			;si����
	loop s0
	ret
	
code ends
end start

