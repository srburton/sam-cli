import pymysql
import logging

from lib.storage.db import db
from lib.storage.entity.user_entity import UserEntity

logger = logging.getLogger()
logger.setLevel(logging.WARN)

class UserDao:
    def __init__(self): pass
    
    def create(self, entity: UserEntity)-> int:
        with db.cursor() as cur:
            try:
                cur.execute("""
                                INSERT INTO user (name, surname,  email, created) 
                                VALUES(%s,%s,%s,%s)
                            """, [
                    entity.name,
                    entity.surname,
                    entity.email,
                    entity.created
                ])        
                db.commit()
                return cur.lastrowid
            except pymysql.MySQLError as e:
                logger.warn(e)
                return None