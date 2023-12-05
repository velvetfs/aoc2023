module Main where

import           Data.List

data Scorecard = Scorecard
  { winners :: [Int]
  , got     :: [Int]
  } deriving (Show)

main :: IO ()
main = do
  part2

part1 :: IO ()
part1 = do
  content <- readFile "in/1.in"
  let ls = lines content
  let scorecards = map (\l -> scorecardFromTuple (separateAtBar (stripIndex l))) ls
  let result = sum (map (scoreFromCount . countScorecardWinners) scorecards)
  print result

part2 :: IO ()
part2 = do
  content <- readFile "in/1.in"
  let ls = lines content
  let scorecards = map (\l -> scorecardFromTuple (separateAtBar (stripIndex l))) ls
  let counts = map countScorecardWinners scorecards
  let dwindling = dwindle counts
  let result = sum (map countMultipliedCards dwindling)
  print result

dwindle' :: Int -> [a] -> [[a]]
dwindle' n xs = (take n (iterate (drop 1) xs))

dwindle :: [a] -> [[a]]
dwindle xs = dwindle' (length xs) xs

scoreFromCount :: Int -> Int
scoreFromCount n
  | n > 2 = 2^(n-1)
  | otherwise = n

countMultipliedCards :: [Int] -> Int
countMultipliedCards []     = 0
countMultipliedCards (x:xs) = 1 + sum (map countMultipliedCards dwindled)
  where
    dwindled = dwindle' x xs

countScorecardWinners :: Scorecard -> Int
countScorecardWinners sc = foldl (\acc x -> if binarySearch w x then acc + 1 else acc) 0 g
  where
    w = winners sc
    g = got sc

binarySearch :: Ord a => [a] -> a -> Bool
binarySearch [] _  = False
binarySearch [x] t = x == t
binarySearch xs t = (pivot == t) || binarySearch left t || binarySearch right t
  where
    i = (length xs) `div` 2
    pivot = xs !! i
    left = take i xs
    right = drop (i) xs

scorecardFromTuple :: (String, String) -> Scorecard
scorecardFromTuple (a, b) = Scorecard (sort (map read (split' a))) (sort (map read (split' b)))

split' :: String -> [String]
split' = split (== ' ')

split :: (a -> Bool) -> [a] -> [[a]]
split _ [] = []
split p xs
  | null left = []
  | otherwise = left : split p right
  where
    stripped = dropWhile p xs
    (left, right) = break p stripped

separateAtBar :: String -> (String, String)
separateAtBar s = (a, b)
  where
    (a, b') = break (== '|') s
    b = (drop 1) b'

stripIndex :: String -> String
stripIndex = (drop 1) . snd . (break (== ':'))
