import AirForce

class Fighter(AirForce.AirForce):
    def __init__(self, missile_num):
        self.missle_num = missile_num
    def take_off(self):
        print("전투기 발진")
    def fly(self):
        print("전투기 출격")
    def attack(self):
        print("미사일 투하")
    def land(self):
        print("전투기 착륙")

