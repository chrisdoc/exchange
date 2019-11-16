module Lib
    ( fetchRates
    ) where

fetchRates :: String -> IO ()
fetchRates baseCurrency = putStrLn ("someFunc" ++ baseCurrency)
