import pymysql
import logging

from lib.settings import settings

logger = logging.getLogger()
logger.setLevel(logging.INFO)

try:
    db = pymysql.connect(
        host=settings.get('DB_HOST'), 
        user=settings.get('DB_USER'), 
        passwd=settings.get('DB_PASSWORD'),
        db=settings.get('DB_NAME'), 
        connect_timeout=5
    )
except pymysql.MySQLError as e:
    logger.error("ERROR: Unexpected error: Could not connect to MySQL instance.")
    logger.error(e)