

def main():
    word_to_num = {
        "one": 1,
        "two": 2,
        "three": 3,
        "four": 4,
        "five" : 5,
        "six": 6,
        "seven": 7,
        "eight": 8,
        "nine": 9
    }
    with open("input.txt") as f:
        lines = f.readlines()
    total = 0
    for line in lines:
        numbers = list(str(value) for value in word_to_num.values()) + list(word_to_num.keys())
        matches = {line.find(number): number if number in line else None for number in numbers}
        matches.pop(-1)
        first, last = matches[min(matches.keys())], matches[max(matches.keys())]
        first_digit = word_to_num[first] if first in word_to_num.keys() else int(first)
        last_digit = word_to_num[last] if last in word_to_num.keys() else int(last)
        total += (first_digit * 10) + last_digit
    print(total)

if __name__ == "__main__":
    main()