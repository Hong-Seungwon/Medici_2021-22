
from Fighter import Fighter
from Boomber import Boomber

def war_game(airforce):
    airforce.take_off()
    airforce.fly()
    airforce.attack()
    airforce.land()

f15 = Fighter(15)
war_game(f15)
print("="*20)
b29 = Boomber(15)
war_game(b29)
print("="*20)