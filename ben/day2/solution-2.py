from pathlib import Path as P
path = P(__file__).parent / 'input/input-1.txt'
file = open(path, "r")
lines = file.readlines()
file.close()

power = 0





for i, game in enumerate(lines):
    min_red = 0
    min_green = 0
    min_blue = 0
    game = game.split(":")[1].strip().replace(",", "").replace(";", "").split(" ")
    num = -1

    for item in game: 
        if item.isdigit(): 
            num = int(item)
            continue
        if item == "red" and num > min_red:
            min_red = num
        if item == "green" and num > min_green:
            min_green = num
        if item == "blue" and num > min_blue:
            min_blue = num
        num = -1

    power += min_red * min_green * min_blue

print(power)
