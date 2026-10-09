#include "blink_adapters.h"
#include "delay.h"
#include "error_port.h"
#include "gpio_drv.h"
#include "sm_example.h"

sm_example_t sm_example;
error_port_t error_port;

int main(void) {

  gpio_set_direction(GPIO_NUM_8, GPIO_OUTPUT);
  gpio_write(GPIO_NUM_8, 0U);

  blink_adapters_register_function(&error_port);
  sm_example_init(&sm_example, &error_port);

  while (1) {
    sm_example.state = STS_RUN;
    run(&sm_example);
    delay_ms(500U);
    sm_example.state = STS_ERROR;
    run(&sm_example);
  }

  return 0;
}
