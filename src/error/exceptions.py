import traceback



class ConnectionError(Exception):

    def __init__(self, connection_type, host, write_traceback: bool = True):
        self.connection_type = connection_type
        self.host = host
        self.write_traceback = write_traceback
        self.message = f'Failed to connect to {self.connection_type!r} on {self.host}'
        super().__init__(self.message)

    def to_json(self) -> dict:
        data = {
            'connection_type': self.connection_type,
            'host': self.host,
            'message': self.message
        }
        if self.write_traceback:
            data['traceback'] = traceback.format_exc()
        return data
