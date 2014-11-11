{-# LANGUAGE DeriveGeneric #-}

import           Data.Aeson
import           GHC.Generics

data ResqueJob = ResqueJob { className :: String
                           , args      :: String
                           } deriving (Show, Generic)

instance FromJSON ResqueJob
instance ToJSON ResqueJob
