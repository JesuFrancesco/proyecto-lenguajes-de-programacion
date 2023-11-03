{-# LANGUAGE DeriveGeneric #-}
import System.Environment
import GHC.Generics
import Data.Maybe
import Data.Aeson
import qualified Data.ByteString.Lazy as B

data Libro = Libro { tituloL :: String
                         , areaL :: String
                         , autorL :: String
                         , paginasL :: Int
                         , yearPublicacionL :: Int
                         , stockL :: Int
                         , claseL :: String                         
                         } deriving (Show, Generic)

data Journal = Journal { tituloJ :: String
                         , areaJ :: String
                         , autorJ :: String
                         , yearPublicacionJ :: Int
                         , stockJ :: Int
                         , claseJ :: String                         
                         } deriving (Show, Generic)

data ActaCongreso = ActaCongreso { tituloAC :: String
                         , areaAC :: String
                         , autorAC :: String
                         , yearPublicacionAC :: Int
                         , stockAC :: Int
                         , claseAC :: String                         
                         } deriving (Show, Generic)


instance FromJSON Libro
instance ToJSON Libro

instance FromJSON Journal
instance ToJSON Journal

instance FromJSON ActaCongreso
instance ToJSON ActaCongreso

leerJSON :: FilePath -> IO (Maybe [Value])
leerJSON ruta = do
  contenido <- B.readFile ruta
  return $ decode contenido

main :: IO ()
main = do
    input <- getArgs -- lista de argumentos

    putStrLn $ "Input: " ++ show input

    objects <- leerJSON "data_material\\material.json"
    case objects of
        Nothing -> putStrLn "Error, no se pudo castear el archivo JSON"
        Just objs -> putStrLn $ (show objs)