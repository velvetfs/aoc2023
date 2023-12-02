from pathlib import Path as P
# For each line, for each character, check if the character is a number. Keep the first and last numbers, and use their digits to make a 2 digit number. Then sum all 2 digit numbers together. Return the answer
path = P(__file__).parent / 'input/input-1.txt'
file = open(path, "r")
lines = file.readlines()
file.close()
total = 0
for line in lines:
    numbers = []
    for char in line:
        if char.isdigit():
            numbers.append(char)
    total += int(numbers[0] + numbers[-1])
print(total)