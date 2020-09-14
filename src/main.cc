#include <stdio.h>
#include "./analizador/driver.h"

int main() {
	Driver driver;
	driver.parse("entrada.txt");
	return 0;
}