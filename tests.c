#include <stdio.h>
#include "functions.h"

void test_add() {
    int result = add(2, 3);
    if (result == 5) {
        printf("test_add passed\n");
    } else {
        printf("test_add failed\n");
    }
}

int main() {
    test_add();
    return 0;
}
