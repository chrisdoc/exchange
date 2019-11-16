{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( fetchRates
    ) where

import Control.Monad.IO.Class
import Data.Aeson
import qualified Data.ByteString.Lazy as B
import Data.Map (Map)
import Data.Maybe
import GHC.Generics
import Network.HTTP.Req


data Rates = Rates {
    base :: String
    , date :: String
    , rates :: Map String Double
} deriving (Generic, Show)

instance FromJSON Rates

fetchRates :: String -> IO ()
fetchRates baseCurrency = runReq defaultHttpConfig $ do
    r <- req GET 
        (https "api.exchangeratesapi.io" /: "latest")
        NoReqBody
        bsResponse
        ("base" =: baseCurrency)
    let body = responseBody r
    let rates :: Rates 
        rates = fromJust (decode (B.fromStrict body))
    liftIO $ print $ rates
