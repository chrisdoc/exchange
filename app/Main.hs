{-# LANGUAGE DataKinds          #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE FlexibleInstances  #-}  -- One more extension.
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE StandaloneDeriving #-}  -- To derive Show
{-# LANGUAGE TypeOperators      #-}

module Main where

import Data.Maybe
import Options.Generic    
import Lib

data Command w = Command {
    base :: w ::: Maybe String <?> "Base currency which is used for conversion"
} deriving (Generic)

instance ParseRecord (Command Wrapped)
deriving instance Show (Command Unwrapped)

defaultToUsd :: Maybe String -> String
defaultToUsd = fromMaybe "USD"

main :: IO ()
main = do
    x <- unwrapRecord "Conversion"
    let baseCurrency = defaultToUsd (base x)
    fetchRates baseCurrency
