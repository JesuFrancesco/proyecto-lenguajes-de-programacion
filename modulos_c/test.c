#include <stdio.h>
#include <string.h>

const char* func(const char *str){
    return str;
}

int main(int argc, char const *argv[])
{
    if (argc <= 1) return 0;
    
    printf("Autor desde C: %s\n", func(argv[1]));
    return 0;
}
