from abc import ABC, abstractmethod
from typing import Any, List
from src.connectors import OracleConnector


class BaseView(ABC):

    primary_key = 'UNIDADE_FABRIL'

    def __init__(self, request):
        self.request = request
        self.db = OracleConnector()
        self._check_self_attributes()

    def _check_self_attributes(self):
        if not hasattr(self, 'view_name'):
            raise AttributeError('view_name is required')
        if not hasattr(self, 'primary_key'):
            raise AttributeError('primary_key is required')

    def GET(self, parameter: Any) -> List[dict]:
        query = f"SELECT * FROM {self.view_name} where {self.primary_key} = {parameter}"
        result = self.db.execute(query)
        return result
