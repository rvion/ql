module Test where

import Control.Monad

import Data.Char(chr, ord)
import Data.List
import Control.Applicative
--
readI :: IO Int
readI = read <$> getLine
readIs :: IO [Int]
readIs = map read . words <$> getLine
read2 :: [Int]->(Int,Int)
read2 (a:b:_) = (a,b)

a :: String -> Char
a s = head $ filter (\x -> elem x "1234567890") s
