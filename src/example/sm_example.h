#ifndef SM_EXAMPLE_H
#define SM_EXAMPLE_H

#include "error_port.h"
#include <stdbool.h>
typedef enum
{
    STS_RUN,
    STS_STOP, /*currently unused*/
    STS_ERROR,
} sm_example_state_t;

typedef struct
{
    sm_example_state_t state;
    sm_example_state_t prev_state;
    error_port_t port;
} sm_example_t;

bool sm_example_init(sm_example_t *sm, error_port_t *port);
sm_example_state_t run(sm_example_t *sm);

#endif
