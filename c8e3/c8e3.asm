ST7/

;************************************************************************
; TITLE:                
; AUTHOR:               
; DESCRIPTION:          
;************************************************************************

	TITLE "SQUELET.ASM"
	
	MOTOROLA
	
	#include "ST7Lite2.INC"

	; Enlever le commentaire si vous utilisez les afficheurs
;	#include "MAX7219.INC"


;************************************************************************
;
;  ZONE DE DECLARATION DES SYMBOLES
;
;************************************************************************



;************************************************************************
;
;  FIN DE LA ZONE DE DECLARATION DES SYMBOLES
;
;************************************************************************

	
	BYTES
	
	segment byte 'ram0'

;************************************************************************
;
;  ZONE DE DECLARATION DES VARIABLES
;
;************************************************************************



;************************************************************************
;
;  FIN DE LA ZONE DE DECLARATION DES VARIABLES
;
;************************************************************************


        WORDS

	segment byte 'rom'

;************************************************************************
;
;  ZONE DE DECLARATION DES CONSTANTES
;
;************************************************************************




;************************************************************************
;
;  FIN DE LA ZONE DE DECLARATION DES CONSTANTES
;
;************************************************************************

;------------------------------------------------------------------------

;************************************************************************
;
;  ZONE DE DECLARATION DES SOUS-PROGRAMMES
;
;************************************************************************

pwm_q1:
	;atr=96 = $060
	LD	A,#$0
	LD	ATRH,A;ATRH : 4 bits MSB de la valeur de ATR,
	
	LD	A,#$60
	LD	ATRL,A;ATRL : 8 bits LSB de la valeur de ATR,
	
	;dcr=2096 = $830
	LD	A,#$8
	LD	DCR0H,A;DCR0H : 4 MSB de la valeur de DCR,
	
	LD	A,#$30
	LD	DCR0H,A;DCR0L : 8 LSB de la valeur de DCR.
	
	LD A,#1
	LD TRANCR,A;prise en compte
	RET
	
	
pwm_q2:
	;atr=50 = $032
	LD	A,#$0
	LD	ATRH,A;ATRH : 4 bits MSB de la valeur de ATR,
	
	LD	A,#$32
	LD	ATRL,A;ATRL : 8 bits LSB de la valeur de ATR,
	
	;dcr=4079 = $FEF
	LD	A,#$F
	LD	DCR0H,A;DCR0H : 4 MSB de la valeur de DCR,
	
	LD	A,#$EF
	LD	DCR0H,A;DCR0L : 8 LSB de la valeur de DCR.
	
	LD A,#1
	LD TRANCR,A;prise en compte
	RET

;************************************************************************
;
;  FIN DE LA ZONE DE DECLARATION DES SOUS-PROGRAMMES
;
;************************************************************************


;************************************************************************
;
;  PROGRAMME PRINCIPAL
;
;************************************************************************

main:
	RSP			; Reset Stack Pointer
	
	LD	A,#$10
	LD	ATCSR,A;ATCSR = $10 (horloge timer = horloge CPU)
	
	LD	A,#$01
	LD	PWMCR,A;PWMCR = $01 (sortie PWM0 sélectionnée),
	
	LD	A,$00
	LD	PWM0CSR,A;PWM0CSR = $00 (si OP0 = 0) ou $02 (si OP0 = 1),
	
	call pwm_q1
	;call pwm_q2

boucl
	WFI
	JP	boucl



;************************************************************************
;
;  ZONE DE DECLARATION DES SOUS-PROGRAMMES D'INTERRUPTION
;
;************************************************************************


dummy_rt:	IRET	; Procédure vide : retour au programme principal.



;************************************************************************
;
;  ZONE DE DECLARATION DES VECTEURS D'INTERRUPTION
;
;************************************************************************


	segment 'vectit'


		DC.W	dummy_rt	; Adresse FFE0-FFE1h
SPI_it		DC.W	dummy_rt	; Adresse FFE2-FFE3h
lt_RTC1_it	DC.W	dummy_rt	; Adresse FFE4-FFE5h
lt_IC_it	DC.W	dummy_rt	; Adresse FFE6-FFE7h
at_timerover_it	DC.W	dummy_rt	; Adresse FFE8-FFE9h
at_timerOC_it	DC.W	dummy_rt	; Adresse FFEA-FFEBh
AVD_it		DC.W	dummy_rt	; Adresse FFEC-FFEDh
		DC.W	dummy_rt	; Adresse FFEE-FFEFh
lt_RTC2_it	DC.W	dummy_rt	; Adresse FFF0-FFF1h
ext3_it		DC.W	dummy_rt	; Adresse FFF2-FFF3h
ext2_it		DC.W	dummy_rt	; Adresse FFF4-FFF5h
ext1_it		DC.W	dummy_rt	; Adresse FFF6-FFF7h
ext0_it		DC.W	dummy_rt	; Adresse FFF8-FFF9h
AWU_it		DC.W	dummy_rt	; Adresse FFFA-FFFBh
softit		DC.W	dummy_rt	; Adresse FFFC-FFFDh
reset		DC.W	main		; Adresse FFFE-FFFFh


	END

;************************************************************************
