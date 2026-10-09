#ifndef ERROR_MOCK_H
#define ERROR_MOCK_H

#include "error_port.h"

typedef struct
{
    bool error_val;
} error_mock_status_t;

void error_mock_init(error_mock_status_t *data);
void error_mock_save_val(void *ctx, bool value);
void error_mock_register_functions(error_port_t *port,
                                   error_mock_status_t *status);

#endif