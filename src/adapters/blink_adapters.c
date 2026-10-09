#include "blink_adapters.h"
#include "gpio_drv.h"
#include <stdint.h>

void blink_adapters_init(void) {
  gpio_set_direction(GPIO_NUM_8, GPIO_OUTPUT);
  gpio_write(GPIO_NUM_8, 0U);
}

void blink_adapters_register_function(error_port_t *port) {
  if (port == NULL) {
    return;
  }
  port->ctx = NULL;
  port->fire_error = blink_adapters_fire_led;
}

void blink_adapters_fire_led(void *ctx, bool value) {
  /*no pointer guard for ctx cause it's NULL in this scenario*/
  uint32_t val = (uint32_t)value;
  gpio_write(GPIO_NUM_8, val);
}
