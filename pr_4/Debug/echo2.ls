   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  43                     ; 6 void initPin(void)
  43                     ; 7 {
  45                     	switch	.text
  46  0000               _initPin:
  50                     ; 8     GPIOE->DDR =0x00;///bouton pour complement A1
  52  0000 725f5016      	clr	20502
  53                     ; 9     GPIOE->CR1 = 0x01;
  55  0004 35015017      	mov	20503,#1
  56                     ; 10     GPIOE->CR2 = 0x00;
  58  0008 725f5018      	clr	20504
  59                     ; 12     GPIOC -> DDR = 0x00;///Entrée bouton
  61  000c 725f500c      	clr	20492
  62                     ; 13 	GPIOC -> CR1 = 0x00;
  64  0010 725f500d      	clr	20493
  65                     ; 14 	GPIOC -> CR2 = 0x00;
  67  0014 725f500e      	clr	20494
  68                     ; 16 	GPIOB -> DDR = 0xFF;///sortie des leds
  70  0018 35ff5007      	mov	20487,#255
  71                     ; 17 	GPIOB -> CR1 = 0xFF;
  73  001c 35ff5008      	mov	20488,#255
  74                     ; 18 	GPIOB -> CR2 = 0x00;
  76  0020 725f5009      	clr	20489
  77                     ; 20 	GPIOA -> DDR = 0x00;///dernier bouton 8 eme led
  79  0024 725f5002      	clr	20482
  80                     ; 21 	GPIOA -> CR1 = 0x00;
  82  0028 725f5003      	clr	20483
  83                     ; 22 	GPIOA -> CR2 = 0x00;
  85  002c 725f5004      	clr	20484
  86                     ; 24 }
  89  0030 81            	ret
 124                     ; 26 void programme4(void)
 124                     ; 27 {
 125                     	switch	.text
 126  0031               _programme4:
 128  0031 88            	push	a
 129       00000001      OFST:	set	1
 132                     ; 29     initPin();
 134  0032 adcc          	call	_initPin
 136  0034               L73:
 137                     ; 33 		value = GPIOC -> IDR;		
 139  0034 c6500b        	ld	a,20491
 140  0037 6b01          	ld	(OFST+0,sp),a
 141                     ; 34 		if(GPIOA -> IDR & MASKLAST)
 143  0039 c65001        	ld	a,20481
 144  003c a502          	bcp	a,#2
 145  003e 2708          	jreq	L34
 146                     ; 36 			value = value |0x01;
 148  0040 7b01          	ld	a,(OFST+0,sp)
 149  0042 aa01          	or	a,#1
 150  0044 6b01          	ld	(OFST+0,sp),a
 152  0046 2006          	jra	L54
 153  0048               L34:
 154                     ; 39 			value = value &0xFE;
 156  0048 7b01          	ld	a,(OFST+0,sp)
 157  004a a4fe          	and	a,#254
 158  004c 6b01          	ld	(OFST+0,sp),a
 159  004e               L54:
 160                     ; 41         if(GPIOE->IDR & BUTTONCOMPLEMENT)
 162  004e c65015        	ld	a,20501
 163  0051 a501          	bcp	a,#1
 164  0053 270b          	jreq	L74
 165                     ; 43             GPIOB ->ODR = (~value & 0xFF) + 1;
 167  0055 7b01          	ld	a,(OFST+0,sp)
 168  0057 43            	cpl	a
 169  0058 a4ff          	and	a,#255
 170  005a 4c            	inc	a
 171  005b c75005        	ld	20485,a
 173  005e 20d4          	jra	L73
 174  0060               L74:
 175                     ; 47             GPIOB->ODR = value;
 177  0060 7b01          	ld	a,(OFST+0,sp)
 178  0062 c75005        	ld	20485,a
 179  0065 20cd          	jra	L73
 192                     	xdef	_programme4
 193                     	xdef	_initPin
 212                     	end
