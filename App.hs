{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TypeOperators #-}
module App where

import Servant
import Servant.JS
import Servant.Server
import Data.Aeson
import GHC.Generics
import Data.List (intercalate)
import Control.Monad.Trans.Except (ExceptT)


type Handler = ExceptT ServantErr IO

type API = "position" :> Capture "x" Int :> Capture "y" Int :> Get '[JSON] Position
      :<|> "hello" :> QueryParam "name" String :> Get '[JSON] HelloMessage
      :<|> "marketing" :> ReqBody '[JSON] ClientInfo :> Post '[JSON] Email

data Position = Position { xCoord :: Int , yCoord :: Int } deriving Generic
instance ToJSON Position

newtype HelloMessage = HelloMessage { msg :: String } deriving Generic
instance ToJSON HelloMessage

data ClientInfo = ClientInfo
  { clientName, clientEmail :: String
  , clientAge :: Int
  , clientInterestedIn :: [String]
  } deriving Generic
instance FromJSON ClientInfo
instance ToJSON ClientInfo

data Email = Email{from, to, subject, body :: String} deriving Generic
instance ToJSON Email

server3 :: Server API
server3 = position
     :<|> hello
     :<|> marketing

  where position :: Int -> Int -> Handler Position
        position x y = return (Position x y)

        hello :: Maybe String -> Handler HelloMessage
        hello mname = return . HelloMessage $ case mname of
          Nothing -> "Hello, anonymous coward"
          Just n  -> "Hello, " ++ n

        marketing :: ClientInfo -> Handler Email
        marketing clientinfo = return (emailForClient clientinfo)
          where
            emailForClient :: ClientInfo -> Email
            emailForClient c = Email from' to' subject' body'
              where
                from'    = "great@company.com"
                to'      = clientEmail c
                subject' = "Hey " ++ clientName c ++ ", we miss you!"
                body'    = "Hi " ++ clientName c ++ ",\n\n"
                        ++ "Since you've recently turned " ++ show (clientAge c)
                        ++ ", have you checked out our latest "
                        ++ intercalate ", " (clientInterestedIn c)
                        ++ " products? Give us a visit!"
