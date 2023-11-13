#include "p16f887.inc"

; CONFIG1
; __config 0x28D5
 __CONFIG _CONFIG1, _FOSC_INTRC_CLKOUT & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _CP_OFF & _CPD_OFF & _BOREN_OFF & _IESO_OFF & _FCMEN_ON & _LVP_OFF
; CONFIG2
; __config 0x3FFF
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF

    LIST p=16F887
   
N EQU 0xC0
cont1 EQU 0x20
cont2 EQU 0x21
cont3 EQU 0x22
var5  EQU 0x23
 
 
    ORG	0x00
    GOTO INICIO
    
INICIO
    BCF STATUS,RP0
    BCF STATUS,RP1 
    CLRF PORTA
    CLRF PORTB
    BSF STATUS, RP0
    CLRF TRISA
    CLRF TRISB
    BSF STATUS,RP1
    CLRF ANSEL
    BCF STATUS,RP0
    BCF STATUS,RP1

LOOP
    MOVLW 0x80
    MOVWF PORTB
    MOVWF var5
    
secuencia1_parte1
    RRF var5
    IORWF var5,0
    MOVWF var5
    MOVWF PORTB
    CALL RETARDO
    BTFSS PORTB, 4
    GOTO secuencia1_parte1
    
    MOVLW 0x8
    MOVWF PORTB
    
secuencia1_parte2
    nop
    RRF PORTB
    CALL RETARDO
    BTFSS PORTB, 0
    GOTO secuencia1_parte2
    GOTO LOOP
     
RETARDO
    MOVLW N
    MOVWF cont1
    
REP_1
    MOVLW N
    MOVWF cont2
    
REP_2
    DECFSZ cont2,1
    GOTO REP_2
    DECFSZ cont1,1
    GOTO REP_1
    RETURN
    
END