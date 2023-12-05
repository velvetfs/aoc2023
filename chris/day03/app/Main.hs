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
  part1

part1 :: IO ()
part1 = do
  content <- readFile "in/ex1.in"
  let ls = lines content
  let zippedLines = enumerate (map enumerate ls)
  let filtered = map (\(r, row) -> (r, filterOutNonNumbers row)) zippedLines
  let grouped = map (\(r, row) -> (r, foldl groupEnumeratedNums [] row)) filtered
  let enginePartArray = map (\(r, row) -> map (enginePartFromGroupedNums r) row) grouped
  let symbolCoords = map coordsOfSymbols zippedLines
  print symbolCoords

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

coordsOfSymbols :: (Int, [(Int, Char)]) -> [Coord]
coordsOfSymbols (y, xs) = map (\(x, _) -> Coord x y) (filter (\(_, c) -> isSymbol c) xs)
