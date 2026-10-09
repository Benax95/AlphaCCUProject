#ifndef ERROR_PORT_H
#define ERROR_PORT_H

/*Example of port implementation*/

#include <stdbool.h>
typedef struct
{
    void *ctx;
    void (*fire_error)(void *ctx, bool value);
} error_port_t;

#endif
