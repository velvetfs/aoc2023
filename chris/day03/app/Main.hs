module Main where

data EnginePart =
  EnginePart
    { number        :: Int
    , rowIndex      :: Int
    , startColIndex :: Int
    , endColIndex   :: Int
    } deriving (Show)

data Coord =
  Coord
    { _x :: Int
    , _y :: Int
    } deriving (Show)

main :: IO ()
main = do
  part2

part1 :: IO ()
part1 = do
  content <- readFile "in/1.in"
  let ls = lines content
  let zippedLines = enumerate (map enumerate ls)
  let filtered = map (\(r, row) -> (r, filterOutNonNumbers row)) zippedLines
  let grouped = map (\(r, row) -> (r, foldl groupEnumeratedNums [] row)) filtered
  let enginePartArray = concatMap (\(r, row) -> map (enginePartFromGroupedNums r) row) grouped
  let symbolCoords = concatMap coordsOfSymbols zippedLines
  let result = sum (brokenEnginePartNumbers symbolCoords enginePartArray)
  print result

part2 :: IO ()
part2 = do
  content <- readFile "in/1.in"
  let ls = lines content
  let zippedLines = enumerate (map enumerate ls)
  let filtered = map (\(r, row) -> (r, filterOutNonNumbers row)) zippedLines
  let grouped = map (\(r, row) -> (r, foldl groupEnumeratedNums [] row)) filtered
  let enginePartArray = concatMap (\(r, row) -> map (enginePartFromGroupedNums r) row) grouped
  let gearCoords = concatMap coordsOfGears zippedLines
  let gearRatios = gearRatiosFromCoords gearCoords enginePartArray
  let result = sum gearRatios
  print result

gearRatiosFromCoords :: [Coord] -> [EnginePart] -> [Int]
gearRatiosFromCoords [] _         = []
gearRatiosFromCoords coords parts = map (\c -> multiplyTuple (gearRatio parts c)) coords

multiplyTuple :: (Int, Int) -> Int
multiplyTuple (a, b) = a * b

gearRatio :: [EnginePart] -> Coord -> (Int, Int)
gearRatio [] _ = (0, 0)
gearRatio parts coord
  | length numbers /= 2 = (0, 0)
  | otherwise = (head numbers, last numbers)
  where
    numbers = map number (filter (\p -> coordAdjacentToPart p coord) parts)

brokenEnginePartNumbers :: [Coord] -> [EnginePart] -> [Int]
brokenEnginePartNumbers [] _ = []
brokenEnginePartNumbers c p  = map number (filter (enginePartIsBroken c) p)

enginePartIsBroken :: [Coord] -> EnginePart -> Bool
enginePartIsBroken [] _ = False
enginePartIsBroken c p  = any (coordAdjacentToPart p) c

coordAdjacentToPart :: EnginePart -> Coord -> Bool
coordAdjacentToPart p c = (_x c) `elem` xRange && (_y c) `elem` yRange
  where
    xRange = [((startColIndex p) - 1)..((endColIndex p) + 1)]
    r = rowIndex p
    yRange = [(r - 1), r, (r + 1)]

enginePartFromGroupedNums :: Int -> [(Int, Char)] -> EnginePart
enginePartFromGroupedNums r [] = EnginePart r (-1) (-1) (-1)
enginePartFromGroupedNums r nums = EnginePart n r s e
  where
    n = read (concatMap (\(_, c) -> [c]) nums)
    s = fst (head nums)
    e = fst (last nums)

enumerate :: [a] -> [(Int, a)]
enumerate = zip [1..]

groupEnumeratedNums :: [[(Int, Char)]] -> (Int, Char) -> [[(Int, Char)]]
groupEnumeratedNums [] x  = [[x]]
groupEnumeratedNums acc x
  | (fst x) - lastNum > 1 = acc ++ [[x]]
  | otherwise = (init acc) ++ [last acc ++ [x]]
  where lastNum = fst (last (last acc))

filterOutNonNumbers :: [(a, Char)] -> [(a, Char)]
filterOutNonNumbers = filter (not . isNotNumber . snd)

isNotNumber :: Char -> Bool
isNotNumber c = not (c `elem` ['0'..'9'])

nonSymbols :: [Char]
nonSymbols = ['0'..'9'] ++ ['.']

isSymbol :: Char -> Bool
isSymbol = not . notSymbol

notSymbol :: Char -> Bool
notSymbol c = elem c nonSymbols

coordsOfGears :: (Int, [(Int, Char)]) -> [Coord]
coordsOfGears (y, xs) = map (\(x, _) -> Coord x y) (filter (\(_, c) -> c == '*') xs)

coordsOfSymbols :: (Int, [(Int, Char)]) -> [Coord]
coordsOfSymbols (y, xs) = map (\(x, _) -> Coord x y) (filter (\(_, c) -> isSymbol c) xs)
