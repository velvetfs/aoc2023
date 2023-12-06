import functools
import re

def main():
    with open("part1_input.txt") as f:
        races = f.readlines()
    times = [int(num) for num in re.findall('\d+', races[0])]
    record_distances = [int(num) for num in re.findall('\d+', races[1])]
    solution_count = []

    for i, time in enumerate(times):
        this_record_count = 0
        for v in range(time):
            remaining_time = time-v
            distance = v * remaining_time
            if distance > record_distances[i]:
                this_record_count += 1
        solution_count.append(this_record_count)
    print(functools.reduce(lambda x, y: x * y, solution_count))

if __name__ == "__main__":
    main()