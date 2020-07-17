#include <stdio.h>
#include <stdint.h>

void hello_world() {
	printf("hello world from c\n");
}

int32_t foo(int32_t bar, int32_t(*callback)(void*, int32_t)) {
	return callback(0L, bar);
}
