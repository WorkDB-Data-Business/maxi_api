import oracledb
import os
import logging
from ..singleton import Singleton
from ..error.exceptions import ConnectionError

logger = logging.getLogger(__name__)


class OracleConnector(metaclass=Singleton):

    def __init__(self):
        self._connect()
        self._check_connection()

    def _connect(self):
        self.host = os.environ.get("DATABASE_HOST")
        self.port = os.environ.get("DATABASE_PORT")
        try:
            self.cn = oracledb.connect(
                host=self.host,
                port=self.port,
                service_name=os.environ.get("DATABASE_SERVICE_NAME"),
                user=os.environ.get("DATABASE_USER"),
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

    def execute(self, query):
        self.cursor.execute(query)
        return self.cursor.fetchall()
