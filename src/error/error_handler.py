
import logging
from fastapi.responses import JSONResponse
from .exceptions import *


logger = logging.getLogger(__name__)



def handle_mysql_connection_error(request, exc: ConnectionError):
    logger.exception(exc)
    return JSONResponse(
        status_code=500,
        content=exc.to_json()
    )

def handle_generic(request, exc: Exception):
    return JSONResponse(status_code=500, content='Internal error ocurred')



def register_error_handlers(app):
    exception_handlers = {
        ConnectionError: handle_mysql_connection_error,
        Exception: handle_generic
    }
    app.exception_handlers.update(exception_handlers)
