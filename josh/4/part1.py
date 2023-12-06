import re


def main():
    with open("part1_input.txt") as f:
        cards = f.readlines()
    total_points = 0
    for card in cards:
        card = card.split(":")[1].split("|")
        winning_numbers = re.findall('\d+', card[0])
        my_numbers = re.findall('\d+', card[1])
        card_total = 0
        for number in my_numbers:
            if number in winning_numbers:
                if card_total == 0:
                    card_total += 1
                else:
                    card_total *= 2
        total_points +=card_total

    print(total_points)

if __name__ == "__main__":
    main()