{-# LANGUAGE DeriveGeneric #-}

module Network.Resquell where

import           Data.Aeson
import           GHC.Generics

data Queue = Queue { queueName :: String } deriving (Show)

data ResqueJob = ResqueJob { className :: String
                           , args      :: String
                           } deriving (Show, Generic)

instance FromJSON ResqueJob
instance ToJSON ResqueJob

enqueue :: Queue -> ResqueJob -> Bool
enqueue (Queue {queueName = "resque:queue:default"}) job = True

perform :: ResqueJob -> Bool
perform job = True
