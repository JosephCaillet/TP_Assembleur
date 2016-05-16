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

RCCR0 EQU $FFDE

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

valeurUnite	DS.B 1
valeurDizaine	DS.B 1
retenue	DS.B 1
running	DS.B 1


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

;--- Initialisation des registres SPICR, SPISR ainsi que du port PB avec les masques PBDDR et BPOR ---;
;--- PBDDR et PBOR sont également initialisés dans une autre fonction mais ce ne sont pas les mêmes bits qui sont initialisés ---;
init_port_spi:
	ld a,#$0C
	ld SPICR,a
	ld a,#$03
	ld SPISR,a
	ld a,#$5C
	ld SPICR,a
	
	;--- PBDDR = xxxxx1xx
	LD	A,PBDDR
	OR	A,#%00000100
	LD	PBDDR,A
	
	;--- PBOR = xxxxx1xx
	LD	A,PBOR
	OR	A,#%00000100
	LD	PBOR,A
	RET

;----------------------------------------------------------;

;--- Initialise les ports PA et PB avec les masques PADDR, PAOR, PBDDR et PBOR ---;
;--- PBDDR et PBOR sont également initialisés dans une autre fonction mais ce ne sont pas les mêmes bits qui sont initialisés ---;
init_io_ports:
	;--- PADDR = xxxx0xxx
	LD	A,PADDR
	AND	A,#%11110111
	;OR	A,#%00000000
	LD	PADDR,A
	
	;--- PAOR = xxxx1xxx
	LD	A,PAOR
	;AND	A,#%11111111
	OR	A,#%00001000
	LD	PAOR,A
	
	;--- PBDDR = xxxxxxx0
	LD	A,PBDDR
	AND	A,#%11111110
	;OR	A,#%00000000
	LD	PBDDR,A
	
	;--- PBOR = xxxxxxx1
	LD	A,PBOR
	;AND	A,#%11111111
	OR	A,#%00000001
	LD	PBOR,A
	
	RET

;----------------------------------------------------------;

;--- Initialise les masques EICR et EISR pour les interruptions ---;
init_int_mask:
	;--- EICR = 10xxxx10
	ld a,EICR
	and a,#%10111110
	or a,#%10000010
	ld EICR, a
	
	;--- EISR = 00xxxx11
	ld a,EISR
	and a,#%00111111
	or a,#%00000011
	ld EISR,a
	
	rim
	
	ret

;----------------------------------------------------------;

;--- initialise à 0 les variables servant au compteur ---;
init_chrono:
	clr valeurUnite
	clr valeurDizaine
	clr retenue
	ret

;----------------------------------------------------------;

;--- Efface le contenu de l'afficheur ---;
init_aff:
	call MAX7219_Init
	call MAX7219_Clear
	ret

;----------------------------------------------------------;

;--- incrémente la valeur servant à l'afficheur ---;
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
	clr retenue
	jp n_inc_d
		;--- }end_then ---
		;--- else{ ---
inc_d
	add a,retenue
	ld valeurDizaine, a
		;--- }end_else ---
	clr retenue
	;-- }end_then ---
n_inc_d
	
	ret

;----------------------------------------------------------;

;--- change le chiffre de l'unité sur l'afficheur ---;
aff_u:
	ld a,#4
	ld DisplayChar_Digit,a
	ld a, valeurUnite
	ld DisplayChar_Character,a
	call MAX7219_DisplayChar
	ret

;----------------------------------------------------------;

;--- change le chiffre de la dizaine sur l'afficheur ---;
aff_d:
	ld a,#3
	ld DisplayChar_Digit,a
	ld a, valeurDizaine
	ld DisplayChar_Character,a
	call MAX7219_DisplayChar
	ret

;----------------------------------------------------------;

;--- fonction qui permet d'avoir un délai de 0,5 sec dans le programme ---;
tempo:
initBoucle1:
	CLR X
boucle1:
	INC X
	CALL initBoucle2
	CP X,#181
	JRNE boucle1
	RET
initBoucle2:
	CLR Y
boucle2:
	INC Y
	CP Y,#181
	JRNE boucle2
	RET

;---------------------------------------------------------;

;--- applique une constante à la clock afin de corriger la fréquence de fonctionnement ---;
init_oscRC:
	ld A,RCCR0
	ld RCCR,A
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
	;--- appel de toutes les initialisations
	RSP			; Reset Stack Pointer
	call	init_oscRC
	call	init_io_ports
	call	init_int_mask
	call	init_port_spi
	call	init_aff
	call	init_chrono
		
boucl
	;--- maj de l'affichage des unités puis des dizaines
	call	aff_u
	call	aff_d
	
	;--- si running est à 1, on incremente le compteur
	ld	A,running
	cp	A,#0
	JREQ skip_aff	
	
	call	inc_aff

skip_aff:
	call	tempo ;--- 0,5s de délais

	JP	boucl

;************************************************************************
;
;  ZONE DE DECLARATION DES SOUS-PROGRAMMES D'INTERRUPTION
;
;************************************************************************


dummy_rt:	IRET	; Procédure vide : retour au programme principal.

;--- programme d'interruption, mets la variable de fonctionnement à 1 ---;
int_marche:
	ld a,#1
	ld running,a
	iret

;--- programme d'interruption, mets la variable de fonctionnement à 0 ---;
int_arret:
	clr running
	iret

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
ext3_it		DC.W	int_arret	; Adresse FFF2-FFF3h
ext2_it		DC.W	dummy_rt	; Adresse FFF4-FFF5h
ext1_it		DC.W	dummy_rt	; Adresse FFF6-FFF7h
ext0_it		DC.W	int_marche	; Adresse FFF8-FFF9h
AWU_it		DC.W	dummy_rt	; Adresse FFFA-FFFBh
softit		DC.W	dummy_rt	; Adresse FFFC-FFFDh
reset		DC.W	main		; Adresse FFFE-FFFFh


	END

;************************************************************************
