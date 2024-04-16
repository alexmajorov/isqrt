#include <math.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <sys/time.h>
#include <time.h>

#ifndef TESTS
#error TESTS NOT FOUND
#endif

#ifndef STEP
#error STEP NOT FOUND
#endif

#ifndef TESTS
#error TESTS NOT FOUND
#endif

#ifndef REPEAT
#error REPEAT NOT FOUND
#endif

unsigned long long nanoseconds_now(void)
{
    struct timespec val;
    
    clock_gettime(CLOCK_MONOTONIC_RAW, &val);
    
    return val.tv_sec * 1000000000000 + val.tv_nsec;
}

float rsqrt(float number)
{
    return 1.0 / sqrt(number);
}

float fast_rsqrt(float number)
{
    union 
    {
        float    f;
        uint32_t i;
    } conv = { .f = number };

    conv.i  = 0x5f3759df - (conv.i >> 1);
    conv.f *= 1.5F - (number * 0.5F * conv.f * conv.f);
    return conv.f;
}


int main(int argc, char *argv[])
{
    long long unsigned beg, end;

    if (argc != 2)
        return EXIT_FAILURE;

    if (!strcmp(argv[1], "rsqrt"))
    { 
        for (size_t i = 0; i <= TESTS; i += STEP)
        {
            beg = nanoseconds_now();
            for (size_t j = 0; j < REPEAT; ++j) rsqrt(i);
            end = nanoseconds_now();
            printf("%f\n", (float)(end - beg) / REPEAT);
        }
    }
    else if (!strcmp(argv[1], "fast_rsqrt"))
    {
        for (size_t i = 0; i <= TESTS; i += STEP)
        {
            beg = nanoseconds_now();
            for (size_t j = 0; j < REPEAT; ++j) fast_rsqrt(i);
            end = nanoseconds_now();
            printf("%f\n", (float)(end - beg) / REPEAT);
        }
    }
    else
    {
        printf("Error: wrong argument. %s function does not exist.", argv[1]);
        return EXIT_FAILURE;
    }
 
    return EXIT_SUCCESS;
}
