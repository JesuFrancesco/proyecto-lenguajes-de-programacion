#include <stdio.h>

char *func(){
    return "test";
}

int main(int argc, char const *argv[])
{
    if (argc != 2) return 0;
    char r[] = func();
    printf("%s", r);
    return 0;
}
