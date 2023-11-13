import System.Environment (getArgs)
import GHC.Generics ( Generic )
import Data.Aeson
import Control.Applicative
import qualified Data.ByteString.Lazy as B
import Data.Aeson.Key (fromString)

-- "codAlumno": 20193377,
--       "apellidoPaterno": "Campos",
--       "apellidoMaterno": "Navarro",
--       "nombre": "Fernanda",
--       "adeudaLib": false,
--       "librosAdeudados": [
 
--       ],
--       "tieneLibSeparado": false,
--       "libReservados": [
 
--       ],
--       "clase": "Alumno",
--       "tiempo": 0


data Alumno = Alumno { codAlumno :: Integer
                                   , apellidoPaterno :: String
                                   , apellidoMaterno :: String
                                   , nombre :: String
                                   , adeudaLib :: Bool
                                   , librosAdeudados :: [String]
                                   , tieneLibSeparado :: Bool
                                   , libReservados :: [String]
                                   , clase :: String
                                   , tiempo :: Int
                                   } deriving (Show)


instance FromJSON Alumno where
  parseJSON (Object v) = Alumno
                         <$> v .: fromString "codAlumno"
                         <*> v .: fromString "apellidoPaterno"
                         <*> v .: fromString "apellidoMaterno"
                         <*> v .: fromString "nombre"
                         <*> v .: fromString "adeudaLib"
                         <*> v .: fromString "librosAdeudados"
                         <*> v .: fromString "tieneLibSeparado"
                         <*> v .: fromString "libReservados"
                         <*> v .: fromString "clase"
                         <*> v .: fromString "tiempo"


data Profesor = Profesor { codUsuario :: Integer
                                   , aPaternoP :: String
                                   , aMaternoP :: String
                                   , nombreP :: String
                                   , adeudaLibP :: Bool
                                   , librosAdeudadosP :: [String]
                                   , tieneLibSeparadoP :: Bool
                                   , libReservadosP :: [String]
                                   , claseP :: String
                                   , tiempoP :: Int
                                   } deriving (Show)


instance FromJSON Profesor where
  parseJSON (Object v) = Profesor
                         <$> v .: fromString "codProfesor"
                         <*> v .: fromString "apellidoPaterno"
                         <*> v .: fromString "apellidoMaterno"
                         <*> v .: fromString "nombre"
                         <*> v .: fromString "adeudaLib"
                         <*> v .: fromString "librosAdeudados"
                         <*> v .: fromString "tieneLibSeparado"
                         <*> v .: fromString "libReservados"
                         <*> v .: fromString "clase"
                         <*> v .: fromString "tiempo"

ruta :: String
ruta = "../data_usuario/usuarios.json"

-- main = do
--   input <- B.readFile ruta
-- --   let mm = decode input :: Maybe Mathematician
--   case eitherDecode input of
--     -- Nothing -> print "error parsing JSON"
--     -- Just m -> (putStrLn.greet) m
--     Left err -> putStrLn $ "Error: " ++ err
--     -- Right ms -> print (ms :: [Mathematician])
--     -- Right ms -> print (toTuple (ms :: [Alumno]))
--     Right ms -> print (ms :: [Object])

main = do
  input <- B.readFile ruta
  case eitherDecode input of
    Left err -> putStrLn $ "Error: " ++ err
    Right objs -> do
      let alumnos = (filter isAlumno objs) :: [Alumno]
          profesores = (filter isProfesor objs) :: [Profesor]
      print (alumnos :: [Alumno])
      print (profesores :: [Profesor])
  where
    isAlumno (Object v) = case lookup "clase" v of
                            Just "Alumno" -> True
                            _ -> False
    isProfesor (Object v) = case lookup "clase" v of
                              Just "Profesor" -> True
                              _ -> False


-- toTuple :: [Alumno] -> [([String])]
-- toTuple ms = [(libReservados m) | m <- ms]
