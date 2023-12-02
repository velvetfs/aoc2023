from pathlib import Path as P
# For each line, for each character, check if the character is a number. Keep the first and last numbers, and use their digits to make a 2 digit number. Then sum all 2 digit numbers together. Return the answer
# path = P(__file__).parent / 'input/basic-input.txt'
path = P(__file__).parent / 'input/input-1.txt'
file = open(path, "r")
lines = file.readlines()
file.close()
total = 0
other_digits = {"one": 1, "two": 2, "three": 3, "four": 4, "five": 5, "six": 6, "seven": 7, "eight": 8, "nine": 9}
for line in lines:
    numbers = []
    for i, char in enumerate(line):
        if len(line) >= i + 3:
            if line[i:i+3] in other_digits:
                numbers.append(str(other_digits[line[i:i+3]]))
        if len(line) >= i + 4:
            if line[i:i+4] in other_digits:
                numbers.append(str(other_digits[line[i:i+4]]))
        if len(line) >= i + 5:
            if line[i:i+5] in other_digits:
                numbers.append(str(other_digits[line[i:i+5]]))

        if char.isdigit():
            numbers.append(char)
    print(numbers)
    total += int(numbers[0] + numbers[-1])
print(total)