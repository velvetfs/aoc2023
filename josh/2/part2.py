import functools


def main():
    with open("part1_input.txt") as f:
        games = f.readlines()

    total = 0
    for i, game in enumerate(games):
        maximums_per_game = {
            "red": 0,
            "green": 0,
            "blue": 0,
        }
        game_number = i+1
        current_num = []
        game = game.split(":")[1]
        for j, c in enumerate(game):
           if c.isdigit():
               current_num.append(c)
           elif current_num:
               num_integer = int("".join(map(str, current_num)))
               for k in maximums_per_game.keys():
                   if game[j:j + len(k)] == k:
                       if num_integer > maximums_per_game[k]:
                           maximums_per_game[k] = num_integer
                       num_integer = None
                       current_num = []
        total += functools.reduce(lambda x, y: x * y, maximums_per_game.values())
    print(total)
if __name__ == "__main__":
    main()