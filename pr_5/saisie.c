#include "saisie.h"
#define MASKLAST 0x02
#define BUTTONGETDATA  1<<7
#define PSEGMENT 0b11001110
#define LEDIND 0b1111000

void initPin(void)
{
    GPIOC -> DDR = 0x00;///Entrée bouton
	GPIOC -> CR1 = 0x00;
	GPIOC -> CR2 = 0x00;

    GPIOB -> DDR = 0xFF;///sortie des leds
	GPIOB -> CR1 = 0xFF;
	GPIOB -> CR2 = 0x00;
	
	GPIOA -> DDR = 0x00;///dernier bouton 8 eme led
	GPIOA -> CR1 = 0x00;
	GPIOA -> CR2 = 0x00;

    GPIOE -> DDR = 0x00;///button prise de donnée
	GPIOE -> CR1 = BUTTONGETDATA;
	GPIOE -> CR2 = 0x00;


    GPIOA ->DDR = LEDIND;
    GPIOA->CR1 = LEDIND;
    GPIOA ->CR2 = 0x00;

}

void programme(void)
{
    static char caractData;
    static char buffer[10];    
    static char posbuffer;
    static char end;

    end =0;
    posbuffer = 0;

    removeP();
    affindex(posbuffer);
    while (!end)
    {
        GPIOB->ODR = getData();
        if(!(GPIOE->IDR & BUTTONGETDATA))
        {
            caractData =getData();
            buffer[posbuffer] =  caractData;
            posbuffer++;
            affindex(posbuffer);
            if(posbuffer >= 10 || !caractData )
            {
                end = 1;
                affP();
            } 
            
            while (!( GPIOE->IDR & BUTTONGETDATA));
            
        }
    }
    while (( GPIOE->IDR & BUTTONGETDATA));
    while (!( GPIOE->IDR & BUTTONGETDATA));
}

void programme5 (void)
{
    initPin();
    while (1)
        programme();
         
}



char getData(void)
{
    char value;
    value = GPIOC -> IDR;		
		if(GPIOA -> IDR & MASKLAST)
		{
			value = value |0x01;
		}
		else
			value = value &0xFE;
    return value;
}

void affP(void)
{
    GPIOB->ODR = PSEGMENT;
}

void removeP(void)
{
    GPIOB->ODR = 0xFF;
}

void affindex(char num)
{
    char value = ~(num <<3);
    GPIOA->ODR = value;
}