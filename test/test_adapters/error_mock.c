#include "error_mock.h"
#include <stdbool.h>
#include <stddef.h>

void error_mock_init(error_mock_status_t *data) {
  if (data == NULL) {
    return;
  }
  data->error_val = false;
}

void error_mock_save_val(void *ctx, bool value) {
  if (ctx == NULL) {
    return;
  }

  /*Dereference the context pointer*/
  error_mock_status_t *status = (error_mock_status_t *)ctx;

  status->error_val = value;
}

void error_mock_register_functions(error_port_t *port,
                                   error_mock_status_t *status) {
  if (port == NULL || status == NULL) {
    return;
  }

  /*Reference context pointer*/
  port->ctx = status;
  port->fire_error = error_mock_save_val;
}