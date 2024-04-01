import logging
import os


def setup_logging():
    default_level = os.environ.get('LOGGING_LEVEL', 'INFO')
    logging.basicConfig(level=default_level, format=os.environ.get('LOG_FORMAT'))
    logging.getLogger("elasticsearch").setLevel(logging.ERROR)
    logging.getLogger("urllib3").setLevel(logging.ERROR)
    logging.getLogger("geopy").setLevel(logging.ERROR)
    logging.getLogger("boto3").setLevel(logging.ERROR)
    logging.getLogger("botocore").setLevel(logging.ERROR)
    logging.getLogger('ElasticConnector').setLevel(default_level)
    logging.getLogger('SQSConnector').setLevel(default_level)

