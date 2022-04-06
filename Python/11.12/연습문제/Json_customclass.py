import json

class Person():
    def __init__(self, name, age):
        self.name = name 
        self.age = age

    def toJson(self):
        return json.dumps(self, default=lambda x:x.__dict__ , 
                sort_keys=True, indent=4) 

p1 = Person("Tom", 30)
p2 = Person("Jane", 40)

person =[]
person.append(json.loads(p1.toJson()))
person.append(json.loads(p2.toJson()))

json.dumps(person)
