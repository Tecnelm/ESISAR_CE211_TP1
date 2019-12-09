   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  43                     ; 6 void init(void)
  43                     ; 7 {
  45                     	switch	.text
  46  0000               _init:
  50                     ; 8 	GPIOC -> DDR = 0x00;
  52  0000 725f500c      	clr	20492
  53                     ; 9 	GPIOC -> CR1 = 0x00;
  55  0004 725f500d      	clr	20493
  56                     ; 10 	GPIOC -> CR2 = 0x00;
  58  0008 725f500e      	clr	20494
  59                     ; 12 	GPIOB -> DDR = 0xFF;
  61  000c 35ff5007      	mov	20487,#255
  62                     ; 13 	GPIOB -> CR1 = 0xFF;
  64  0010 35ff5008      	mov	20488,#255
  65                     ; 14 	GPIOB -> CR2 = 0x00;
  67  0014 725f5009      	clr	20489
  68                     ; 16 	GPIOA -> DDR = 0x00;
  70  0018 725f5002      	clr	20482
  71                     ; 17 	GPIOA -> CR1 = 0x00;
  73  001c 725f5003      	clr	20483
  74                     ; 18 	GPIOA -> CR2 = 0x00;
  76  0020 725f5004      	clr	20484
  77                     ; 19 }
  80  0024 81            	ret
 104                     ; 21 void setOnLed(void)
 104                     ; 22 {
 105                     	switch	.text
 106  0025               _setOnLed:
 110                     ; 23 	init();
 112  0025 add9          	call	_init
 114  0027               L13:
 115                     ; 26 		GPIOB -> ODR = GPIOC -> IDR;		
 117  0027 55500b5005    	mov	20485,20491
 118                     ; 27 		if(GPIOA -> IDR & MASKLAST)
 120  002c c65001        	ld	a,20481
 121  002f a502          	bcp	a,#2
 122  0031 2706          	jreq	L53
 123                     ; 29 			GPIOB -> ODR = GPIOB ->ODR |0x01;
 125  0033 72105005      	bset	20485,#0
 127  0037 20ee          	jra	L13
 128  0039               L53:
 129                     ; 32 			GPIOB -> ODR = GPIOB ->ODR &0xFE;
 131  0039 72115005      	bres	20485,#0
 132  003d 20e8          	jra	L13
 145                     	xdef	_setOnLed
 146                     	xdef	_init
 165                     	end
