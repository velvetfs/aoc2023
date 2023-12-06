import re

def main():
    with open("part1_input.txt") as f:
        races = f.readlines()

    time = int("".join(re.findall('\d+', races[0])))
    record_distance = int("".join(re.findall('\d+', races[1])))
    record_count = 0

    for v in range(time):
        remaining_time = time-v
        distance = v * remaining_time
        if distance > record_distance:
            record_count += 1
    print(record_count)


if __name__ == "__main__":
    main()
