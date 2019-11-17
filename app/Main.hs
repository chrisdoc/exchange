{-# LANGUAGE DataKinds          #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE FlexibleInstances  #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE TypeOperators      #-}

module Main where

import           Data.Maybe
import           Lib
import           Options.Generic

data Command w =
  Command
    { base :: w ::: Maybe String <?> "Base currency which is used for conversion"
    }
  deriving (Generic)

instance ParseRecord (Command Wrapped)

deriving instance Show (Command Unwrapped)

defaultToUsd :: Maybe String -> String
defaultToUsd = fromMaybe "USD"

main :: IO ()
main = do
  x <- unwrapRecord "Conversion"
  let baseCurrency = defaultToUsd (base x)
  fetchRates baseCurrency
