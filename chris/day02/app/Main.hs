module Main where

import           Data.Maybe (fromMaybe)

data Game = Game
  { red   :: Int
  , green :: Int
  , blue  :: Int
  }
  deriving (Show)

main :: IO ()
main = do
  part1
  part2

part1 :: IO ()
part1 = do
  content <- readFile "in/1.in"
  let ls = lines content
  let gameData = map createGameData ls
  let illegalGames = filter (not . anyGameIsIllegal . snd) gameData
  let result = foldl (\acc x -> acc + fst x) 0 illegalGames
  print result

part2 :: IO ()
part2 = do
  content <- readFile "in/1.in"
  let ls = lines content
  let gameData = map createGameData ls
  let maxColors = map maxOfEachColor $ map snd gameData
  let result = sum (map gamePowers maxColors)
  print result

gamePowers :: (Int, Int, Int) -> Int
gamePowers (r, g, b) = r * g * b

maxOfEachColor :: [Game] -> (Int, Int, Int)
maxOfEachColor games = (maxRed, maxGreen, maxBlue)
  where
    maxRed = maxRedFromGameArray games
    maxGreen = maxGreenFromGameArray games
    maxBlue = maxBlueFromGameArray games

maxColorFromGameArray :: (Game -> Int) -> [Game] -> Int
maxColorFromGameArray _ []       = 0
maxColorFromGameArray f (x : xs) = max (f x) (maxColorFromGameArray f xs)

maxRedFromGameArray :: [Game] -> Int
maxRedFromGameArray = maxColorFromGameArray red

maxGreenFromGameArray :: [Game] -> Int
maxGreenFromGameArray = maxColorFromGameArray green

maxBlueFromGameArray :: [Game] -> Int
maxBlueFromGameArray = maxColorFromGameArray blue

gameFromTupleArray :: [(String, Int)] -> Game
gameFromTupleArray [] = Game 0 0 0
gameFromTupleArray xs = Game r g b
  where
    r = fromMaybe 0 $ lookup "red" xs
    g = fromMaybe 0 $ lookup "green" xs
    b = fromMaybe 0 $ lookup "blue" xs

createGameData :: String -> (Int, [Game])
createGameData ln = (read $ gameIndex, games)
  where
    (gamePrelude, rest) = break (':'==) ln
    gameIndex = drop 5 gamePrelude
    subGames = drop 2 rest
    s = splitSubGames subGames
    ss = map subSubGames s
    plies = map (map splitPly) ss
    games = map gameFromTupleArray plies

splitSubGames :: String -> [String]
splitSubGames [] = []
splitSubGames ln
  | null rest = [subGame]
  | otherwise = subGame : splitSubGames (drop 2 rest)
  where
    (subGame, rest) = break (';'==) ln

subSubGames :: String -> [String]
subSubGames [] = []
subSubGames ln
  | null rest = [subSubGame]
  | otherwise = subSubGame : subSubGames (drop 2 rest)
  where
    (subSubGame, rest) = break (','==) ln

splitPly :: String -> (String, Int)
splitPly ln = (drop 1 rest, read $ ply)
  where
    (ply, rest) = break (' '==) ln

gameIsIllegal :: Game -> Bool
gameIsIllegal (Game r g b) = r > 12 || g > 13 || b > 14

anyGameIsIllegal :: [Game] -> Bool
anyGameIsIllegal []       = False
anyGameIsIllegal (x : xs) = gameIsIllegal x || anyGameIsIllegal xs
