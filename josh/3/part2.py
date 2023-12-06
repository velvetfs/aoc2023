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
    coords = [
        (i, j-1),
        (i, j+1),
        (i-1, j-1),
        (i-1, j+1),
        (i-1, j),
        (i+1, j-1),
        (i+1, j+1),
        (i+1, j)
    ]
    for i, cs in enumerate(possible_valid):
        if cs is not None and is_symbol(cs):
            return True, cs, coords[i]
    return False, None, None
def main():
    with open("part1_input.txt") as f:
        engine_lines = f.readlines()
    symbols_with_coords = {}
    for i, line in enumerate(engine_lines):
       current_num = []
       symbol_neighbor = False
       coord = None
       symbol = None
       for j, c in enumerate(line):
           if c.isdigit():
               current_num.append(c)
               if symbol_neighbor is False and check_neighbors(i, j, engine_lines)[0]:
                   neighbors, symbol, coord = check_neighbors(i, j, engine_lines)
                   symbol_neighbor = True
           elif current_num:
               if symbol_neighbor and symbol == "*":
                   if coord not in symbols_with_coords:
                       symbols_with_coords[coord] = []
                   symbols_with_coords.get(coord).append((symbol, int(''.join(map(str, current_num)))))
               symbol_neighbor = False
               symbol = None
               coord = None
               current_num = []
    product = 0
    for coord, symbols in symbols_with_coords.items():
        if len(symbols) > 1:
            product += symbols[0][1] * symbols[1][1]
    print(product)



if __name__ == "__main__":
    main()