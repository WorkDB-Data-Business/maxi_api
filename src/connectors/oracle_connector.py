import oracledb
import os
import logging
from ..singleton import Singleton
from ..error.exceptions import ConnectionError, MissingRequiredEnvVarError

logger = logging.getLogger(__name__)


class OracleConnector(metaclass=Singleton):

    def __init__(self):
        self._get_config_from_env()
        self._connect()
        self._check_connection()

    def _get_config_from_env(self):
        self.host = os.environ.get("DATABASE_HOST")
        if not self.host:
            raise MissingRequiredEnvVarError("DATABASE_HOST")
        self.port = os.environ.get("DATABASE_PORT")
        if not self.port:
            raise MissingRequiredEnvVarError("DATABASE_PORT")
        self.service_name = os.environ.get("DATABASE_SERVICE_NAME")
        if not self.service_name:
            raise MissingRequiredEnvVarError("DATABASE_SERVICE_NAME")
        self.user = os.environ.get("DATABASE_USER")
        if not self.user:
            raise MissingRequiredEnvVarError("DATABASE_USER")
        if not os.environ.get("DATABASE_PASSWORD"):
            raise MissingRequiredEnvVarError("DATABASE_PASSWORD")

    def _connect(self):
        self.host = os.environ.get("DATABASE_HOST")
        self.port = os.environ.get("DATABASE_PORT")
        try:
            self.cn = oracledb.connect(
                host=self.host,
                port=self.port,
                service_name=self.service_name,
                user=self.user,
                password=os.environ.get("DATABASE_PASSWORD"),
            )
            self.cursor = self.cn.cursor()
            self.connected = True
        except Exception as excp:
            logger.info(f"Oracle connection error: {excp}")
            self.connected = False

    def _check_connection(self):
        if not self.connected or not self.cn.ping():
            raise ConnectionError('Oracle', self.host, write_traceback=True)

    def close(self):
        self.cursor.close()
        self.cn.close()

    def execute(self, query):
        self.cursor.execute(query)
        return self.cursor.fetchall()
