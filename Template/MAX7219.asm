ST7/

;************************************************************************
; TITLE:                MAX7219.ASM
; AUTHOR:               Nicolas Coquelle
; DESCRIPTION:          Bibliothèque pour l'utilisation d'un MAX7219
;                       pour l'affichage sur des afficheurs 7 segments
;************************************************************************

	TITLE "MAX7219.ASM"
	
	MOTOROLA
	
	#include "ST7Lite2.INC"
	

;************************************************************************
;			Déclaration des fonctions et variables publiques
;************************************************************************
	
	PUBLIC	MAX7219_Init
	PUBLIC	MAX7219_ShutdownStart
	PUBLIC	MAX7219_ShutdownStop
	PUBLIC	MAX7219_DisplayTestStart
	PUBLIC	MAX7219_DisplayTestStop
	PUBLIC	MAX7219_SetBrightness, SetBrightness_Bright
	PUBLIC	MAX7219_Clear
	PUBLIC	MAX7219_AllumePoint
	PUBLIC	MAX7219_AfficheP
	PUBLIC	MAX7219_DisplayChar, DisplayChar_Digit, DisplayChar_Character



REG_DECODE		EQU	$09
REG_INTENSITY		EQU	$0A
REG_SCAN_LIMIT		EQU	$0B
REG_SHUTDOWN		EQU	$0C
REG_DISPLAY_TEST	EQU	$0F

INTENSITY_MIN		EQU	$00
INTENSITY_MAX		EQU	$0F

	
	BYTES
	
	segment byte 'ram0'
	
SetBrightness_Bright	DS.B	1

DisplayChar_Digit	DS.B	1
DisplayChar_Character	DS.B	1

Write_RegNumber		DS.B	1
Write_Data		DS.B	1

LookupCode_Character	DS.B	1
LookupCode_CodeOut	DS.B	1

SendByte_Data		DS.B	1
             
             
        WORDS

	segment byte 'rom'

				;0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F
MAX7219_ConvCode	DC.B	$7E,$30,$6D,$79,$33,$5B,$5F,$70,$7F,$7B,$77,$1F,$4E,$3D,$4F,$47



MAX7219_Init:
	push	A
	
	ld	A,#REG_SCAN_LIMIT
	ld	Write_RegNumber,A
	ld	A,#7
	ld	Write_Data,A
	call	MAX7219_Write

	ld	A,#REG_DECODE
	ld	Write_RegNumber,A
	ld	A,#$00
	ld	Write_Data,A
	call	MAX7219_Write

	call	MAX7219_ShutdownStop

	call	MAX7219_DisplayTestStop

	call	MAX7219_Clear

	ld	A,#INTENSITY_MAX
	ld	SetBrightness_Bright,A
	call	MAX7219_SetBrightness

	pop	A
	ret


MAX7219_ShutdownStart:
	push	A

	ld	A,#REG_SHUTDOWN
	ld	Write_RegNumber,A
	ld	A,#0
	ld	Write_Data,A
	call	MAX7219_Write

	pop	A
	ret


MAX7219_ShutdownStop:
	push	A

	ld	A,#REG_SHUTDOWN
	ld	Write_RegNumber,A
	ld	A,#1
	ld	Write_Data,A
	call	MAX7219_Write

	pop	A
	ret


MAX7219_DisplayTestStart:
	push	A

	ld	A,#REG_DISPLAY_TEST
	ld	Write_RegNumber,A
	ld	A,#1
	ld	Write_Data,A
	call	MAX7219_Write

	pop	A
	ret


MAX7219_DisplayTestStop:
	push	A

	ld	A,#REG_DISPLAY_TEST
	ld	Write_RegNumber,A
	ld	A,#0
	ld	Write_Data,A
	call	MAX7219_Write

	pop	A
	ret


MAX7219_SetBrightness:
	push	A

	ld	A,#REG_INTENSITY
	ld	Write_RegNumber,A
	ld	A,SetBrightness_Bright
	and	A,#$0F
	ld	Write_Data,A
	call	MAX7219_Write

	pop	A
	ret


MAX7219_Clear:
	push	A

	clr	A
	ld	Write_Data,A

	clr	A
clearNext:
	ld	Write_RegNumber,A
	call	MAX7219_Write
	inc	A
	cp	A,#9
	jrne	clearNext

	pop	A
	ret


MAX7219_DisplayChar:
	push	A
	
	ld	A,DisplayChar_Digit
	ld	Write_RegNumber,A
	
	ld	A,DisplayChar_Character
	ld	LookupCode_Character,A
	call	MAX7219_LookupCode
	
	ld	A,LookupCode_CodeOut
	ld	Write_Data,A
	
	call	MAX7219_Write

	pop	A
	ret


	
MAX7219_AllumePoint:
	push	A
	
	ld	A,DisplayChar_Digit
	ld	Write_RegNumber,A
	
	ld	A,#%10000000
	ld	Write_Data,A
	
	call	MAX7219_Write

	pop	A
	ret
	
	
MAX7219_AfficheP:
	push	A
	
	ld	A,DisplayChar_Digit
	ld	Write_RegNumber,A
	
	ld	A,#%01100111
	ld	Write_Data,A
	
	call	MAX7219_Write

	pop	A
	ret


MAX7219_LookupCode:
	push	X
	push	A

	clr	A		; Etteint par défaut
	ld	LookupCode_CodeOut,A
	
	ld	X,LookupCode_Character
	cp	X,#$FF
	jreq	finDisp
	
	cp	X,#16
	jruge	finDisp
	ld	A,(MAX7219_ConvCode,X)
	ld	LookupCode_CodeOut,A
	
finDisp:
	pop	A
	pop	X
	ret


MAX7219_Write:
	push	A
	
	bset	PBDR,#2		; LOAD = 1

	ld	A,Write_RegNumber
	ld	SendByte_Data,A
	call	MAX7219_SendByte
	
	ld	A,Write_Data
	ld	SendByte_Data,A
	call	MAX7219_SendByte

	bres	PBDR,#2		; LOAD = 0
	bset	PBDR,#2		; LOAD = 1

	pop	A
	ret


MAX7219_SendByte:
	push	A

	ld	A,SendByte_Data
	ld	SPIDR,A		; La valeur est envoyée lorsqu'elle est mise dans SPIDR
wait	btjf	SPISR,#7,wait	; On attend que le bit SPIF soit à 1 (donnée envoyée)
	ld	A,SPIDR		; Pour effacer le bit SPIF
	
	pop	A
	ret	



	END

;*** (c) 2002  Nicolas Coquelle - ISEM **************************************
