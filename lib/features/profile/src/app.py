from lib.settings import settings
from lib.core.responses import *

from lib.storage.dao.user_dao import UserDao
from lib.storage.entity.user_entity  import UserEntity

def get(event, context):
    return ok(settings.get('DB_HOST'))

def update(event, context):
    user_dao = UserDao()
    u_id = user_dao.create(entity=UserEntity(
        name='Hello', 
        surname='Wo',        
        email='sam-email@pytao.com',    
        created='2022-01-02 10:10:00' 
    ))
    if u_id != None:
        return ok(u_id)
    else:
        return badRequest(None, ['User exist!'])