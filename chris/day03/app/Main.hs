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
    { x :: Int
    , y :: Int
    } deriving (Show)

main :: IO ()
main = do
  part1

part1 :: IO ()
part1 = do
  content <- readFile "in/ex1.in"
  let ls = lines content
  let seq = map numberSequences ls
  let result = map matrixEnum seq
  print result

enumerate :: [a] -> [(Int, a)]
enumerate = zip [1..]

matrixEnum :: Int -> [a] -> [(Int, Int, a)]
matrixEnum i s = map (\x -> addRow (i, x)) s

addRow :: Int -> (Int, a) -> (Int, Int, a)
addRow i t = (i, fst t, snd t)

numberSequences :: String -> [String]
numberSequences s
  | null xs = []
  | otherwise = x : numberSequences xs
  where
    (x, xs) = breakOffNumber s

breakOffNumber :: String -> (String, String)
breakOffNumber [] = ([], [])
breakOffNumber (c:cs)
  | isNotNumber c = ([], cs)
  | otherwise      = let (prefix, suffix) = breakOffNumber cs in (c : prefix, suffix)

isNotNumber :: Char -> Bool
isNotNumber c = not (c `elem` ['0'..'9'])

nonSymbols :: [Char]
nonSymbols = ['0'..'9'] ++ ['.']

isSymbol :: Char -> Bool
isSymbol = not . notSymbol

notSymbol :: Char -> Bool
notSymbol c = elem c nonSymbols

indicesOfSymbols :: String -> [Int]
indicesOfSymbols s = map fst filtered
  where
    zipped = zip [1..] s
    filtered = filter (\(_, c) -> isSymbol c) zipped
