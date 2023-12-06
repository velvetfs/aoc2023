def is_symbol(c):
    return c.isdigit() is False and c != "." and c != " " and c != "\n"

def check_neighbors(i, j, engine_lines):
    possible_valid = [
        engine_lines[i][j-1] if j > 0 else None,
        engine_lines[i][j+1] if j < len(engine_lines[i])-1 else None,
        engine_lines[i-1][j-1] if j > 0 and i > 0 else None,
        engine_lines[i-1][j+1] if j < len(engine_lines[i])-1 and i > 0 else None,
        engine_lines[i-1][j] if i > 0 else None,
        engine_lines[i+1][j-1] if i < len(engine_lines)-1 and j > 0 else None,
        engine_lines[i+1][j+1] if i < len(engine_lines)-1 and j < len(engine_lines[i])-1 else None,
        engine_lines[i+1][j] if i < len(engine_lines)-1 else None
    ]
    for cs in possible_valid:
        if cs is not None and is_symbol(cs):
            return True
    return False
def main():
    with open("part1_input.txt") as f:
        engine_lines = f.readlines()
    valid_numbers = []
    for i, line in enumerate(engine_lines):
       current_num = []
       symbol_neighbor = False
       for j, c in enumerate(line):
           if c.isdigit():
               current_num.append(c)
               if symbol_neighbor is False and check_neighbors(i, j, engine_lines):
                   symbol_neighbor = True
           elif current_num:
               if symbol_neighbor:
                   valid_numbers.append(int(''.join(map(str, current_num))))
               symbol_neighbor = False
               current_num = []

    print(sum(valid_numbers))



if __name__ == "__main__":
    main()