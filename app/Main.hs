{-# LANGUAGE DataKinds          #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE FlexibleInstances  #-}  -- One more extension.
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE StandaloneDeriving #-}  -- To derive Show
{-# LANGUAGE TypeOperators      #-}

module Main where

import Options.Generic    
import Lib

data Command w = Command {
    base :: w ::: Maybe String <?> "Base currency which is used for conversion"
} deriving (Generic)

instance ParseRecord (Command Wrapped)
deriving instance Show (Command Unwrapped)

main :: IO ()
main = do
    x <- unwrapRecord "Conversion"
    print (x :: (Command Unwrapped))
