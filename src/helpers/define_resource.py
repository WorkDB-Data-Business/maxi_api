import logging
from typing import Union, Any, List
from fastapi import Request


logger = logging.getLogger(__name__)

def define_resource(app, endpoint, view):

    @app.get(endpoint+'/_id/{doc_id}')
    def get(request: Request, doc_id: str):
        return view(request).GET(doc_id)

    logger.info(f'Resources for endpoint {endpoint!r} defined')
