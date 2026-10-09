#include "sm_example.h"
#include <stdbool.h>
#include <stdio.h>

sm_example_state_t run(sm_example_t *sm) {
  sm_example_state_t sts;
  bool edge_case = sm->state != sm->prev_state;

  switch (sm->state) {
  case STS_RUN:
    if (edge_case) {
      sm->port.fire_error(sm->port.ctx, false);
    }
    sts = STS_RUN;
    break;
  case STS_STOP:
    sts = STS_STOP;
    break;
  case STS_ERROR:
    /*fire led signal*/
    if (edge_case) {
      sm->port.fire_error(sm->port.ctx, true);
    }
    sts = STS_ERROR;
    break;
  default:
    sts = STS_RUN;
  }

  sm->prev_state = sm->state;
  return sts;
}

bool sm_example_init(sm_example_t *sm, error_port_t *port) {
  if (sm == NULL) {
    return false;
  }

  sm->state = STS_STOP;
  sm->prev_state = sm->state;
  sm->port = *port;

  return true;
}
