ST7/

;************************************************************************
; TITLE:                
; AUTHOR:               
; DESCRIPTION:          
;************************************************************************

	TITLE "c6e4.ASM"
	
	MOTOROLA
	
	#include "ST7Lite2.INC"
	;#include "MAX7219.ASM"
	#include "MAX7219.INC"

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

valeurUnite DS.B 1
valeurDizaine DS.B 1
retenue DS.B 1


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

init_port_spi:
	ld a,#$0C
	ld SPICR,a
	ld a,#$03
	ld SPISR,a
	ld a,#$5C
	ld SPICR,a
	
	LD	A,PBDDR;init PBDDR dire quoi est en push/pull etc
	OR	A,#%00000100
	LD	PBDDR,A
	
	LD	A,PBOR;init PBOR
	OR	A,#%00000100
	LD	PBOR,A
	RET

;----------------------------------------------------------;

init_chrono:
	clr valeurUnite
	clr valeurDizaine
	clr retenue
	ret

;----------------------------------------------------------;

init_aff:
	call MAX7219_Init
	call MAX7219_Clear
	ret

;----------------------------------------------------------;

inc_aff:
	ld a,valeurUnite
	;--- if(a == 9) ---
	cp a,#9
	jrne inc_u
	;--- then{ ---
	clr valeurUnite
	ld x,retenue
	inc x
	ld retenue, x
	jp n_inc_u
	;--- }end_then ---
	;--- else{ ---
inc_u
	inc a
	ld valeurUnite, a
	;--- }end_else ---
	
n_inc_u
	ld x,retenue
	;--- if(x != 0) ---
	cp x,#0
	jreq n_inc_d
	;--- then{ ---
	ld a,valeurDizaine
		;--- if(a == 9) ---
	cp a,#9
	jrne inc_d
		;--- then{ ---
	clr valeurDizaine
	jp n_inc_u
		;--- }end_then ---
		;--- else{ ---
inc_d
	add a,retenue
	ld valeurUnite, a
		;--- }end_else ---
	clr retenue
	;-- }end_then ---
n_inc_d
	
	ret

;----------------------------------------------------------;

aff_u:
	ld a,#4
	ld DisplayChar_Digit,a
	ld a, valeurUnite
	ld DisplayChar_Character,a
	call MAX7219_DisplayChar
	ret

;----------------------------------------------------------;

aff_d:
	ld a,#4
	ld DisplayChar_Digit,a
	ld a, valeurDizaine
	ld DisplayChar_Character,a
	call MAX7219_DisplayChar
	ret

;----------------------------------------------------------;

tempo:
initBoucle1:
	CLR X
boucle1:
	INC X
	CALL initBoucle2
	CP X,#200
	JRNE boucle1
	RET
initBoucle2:
	CLR Y
boucle2:
	INC Y
	CP Y,#200
	JRNE boucle2
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
	
	call init_port_spi
	call init_aff
		
boucl
	call aff_u
	call aff_d
	
	call inc_aff
	
	call tempo

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
