#ifndef BLINK_ADAPTERS_H
#define BLINK_ADAPTERS_H

#include "error_port.h"
#include <stdbool.h>

void blink_adapters_init(void);
void blink_adapters_fire_led(void *ctx, bool value);
void blink_adapters_register_function(error_port_t *port);

#endif /*BLINK_ADAPTERS_H*/
