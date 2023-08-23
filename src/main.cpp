#define F_CPU 16000000

#include <avr/io.h>
#include <util/delay.h>

int main()
{
	// test program
	DDRB |= 1 << DDB5;
	while (1)
	{
		PORTB ^= 1 << PORTB5;
		_delay_ms(1000);
	}
	return 0;
}