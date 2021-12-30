class UserEntity:
    id = int
    name = str
    surname = str
    gender = str
    birth = str
    avatar = str
    email = str
    cell = str
    confirmedEmail = bool
    confirmedCell = bool
    created = str

    def __init__(self, name, surname, email, created):
        self.name = name
        self.surname = surname    
        self.email = email    
        self.created = created
    
    def setId(self, id:int):
        self.id = id    
