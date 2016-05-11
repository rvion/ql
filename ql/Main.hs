module Main where
import Base

type API = "position" :> Capture "x" Int :> Capture "y" Int :> Get '[JSON] Position
      :<|> "hello" :> QueryParam "name" String :> Get '[JSON] HelloMessage
      :<|> "marketing" :> ReqBody '[JSON] ClientInfo :> Post '[JSON] Email
      :<|> "js" :> Get '[JSON] Text
      :<|> "api" :> Get '[JSON] Swagger

main :: IO ()
main = putStrLn "running on port 8080.." >> run 8080 app where
  app :: Application
  app = logStdoutDev $ serve api server

server :: Server API
server  = positionHandler
     :<|> helloHandler
     :<|> marketingHandler
     :<|> (return $ jsForAPI api vanillaJS)
     :<|> (return $ toSwagger $ api)-- decodeUtf8 . toStrict . encode .

positionHandler :: Int -> Int -> Handler Position
positionHandler x y = return (Position x y)

helloHandler :: Maybe String -> Handler HelloMessage
helloHandler mname = return . HelloMessage $ case mname of
  Nothing -> "Hello, anonymous coward"
  Just n  -> "Hello, " ++ n

marketingHandler :: ClientInfo -> Handler Email
marketingHandler c = return (Email from' to' subject' body')
      where
        from'    = "great@company.com"
        to'      = clientEmail c
        subject' = "Hey " ++ clientName c ++ ", we miss you!"
        body'    = "Hi " ++ clientName c ++ ",\n\n"
                ++ "Since you've recently turned " ++ show (clientAge c)
                ++ ", have you checked out our latest "
                ++ intercalate ", " (clientInterestedIn c)
                ++ " products? Give us a visit!"

api :: Proxy API
api = Proxy

--------------------------------

type Handler = ExceptT ServantErr IO

data Position = Position { xCoord :: Int , yCoord :: Int } deriving Generic
instance ToJSON Position
instance ToSchema Position

newtype HelloMessage = HelloMessage { msg :: String } deriving Generic
instance ToJSON HelloMessage
instance ToSchema HelloMessage

data ClientInfo = ClientInfo
  { clientName, clientEmail :: String
  , clientAge :: Int
  , clientInterestedIn :: [String]
  } deriving Generic
instance FromJSON ClientInfo
instance ToJSON ClientInfo
instance ToSchema ClientInfo

data Email = Email{from, to, subject, body :: String} deriving Generic
instance ToJSON Email
instance ToSchema Email
instance ToSchema Swagger where
  declareNamedSchema _ = declareNamedSchema (Proxy :: Proxy Text)
