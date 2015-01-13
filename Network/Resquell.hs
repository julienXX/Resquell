{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Network.Resquell where

import           Data.Aeson
import qualified Data.ByteString               as B
import qualified Data.ByteString.Lazy          as BL
import           Database.Redis
import           GHC.Generics

type Queue = B.ByteString

data ResqueJob = ResqueJob { className :: String
                           , args      :: [String]
                           }
               deriving (Show, Generic)

instance FromJSON ResqueJob
instance ToJSON ResqueJob where
  toJSON (ResqueJob className args) =
    object [ "class"  .= className
           , "args"   .= args ]

enqueue :: Queue -> ResqueJob -> IO (Either Reply Integer)
enqueue queue job = do
  conn <- connect defaultConnectInfo
  runRedis conn $ do
    sadd "queues" [queue]
    rpush queue [toStrict (encode job)]

toStrict :: BL.ByteString -> B.ByteString
toStrict = B.concat . BL.toChunks
