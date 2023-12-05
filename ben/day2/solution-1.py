from pathlib import Path as P
path = P(__file__).parent / 'input/input-1.txt'
file = open(path, "r")
lines = file.readlines()
file.close()

id_sum = 0

red = 12
green = 13
blue = 14



for i, game in enumerate(lines):
    game = game.split(":")[1].strip().replace(",", "").replace(";", "").split(" ")
    num = -1
    possible = True
    for item in game: 
        if item.isdigit(): 
            num = int(item)
            continue
        if item == "red" and num > red:
            possible = False
        if item == "green" and num > green:
            possible = False
        if item == "blue" and num > blue:
            possible = False
        num = -1
    if possible:
        id_sum += i + 1

print(id_sum)
