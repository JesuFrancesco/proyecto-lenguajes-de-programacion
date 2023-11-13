import System.Environment
import Data.List (nub)

-- Funciones para obtener limpiar el input por terminal
borrarPrimerChar :: [String] -> [String]
borrarPrimerChar [] = []
borrarPrimerChar (x:xs) = (tail x) : xs

borrarComas :: [String] -> [String]
borrarComas = map init

convertirATupla :: String -> (String, Bool)
convertirATupla s = read s :: (String, Bool)

leerLista :: [String] -> [(String, Bool)]
leerLista = map convertirATupla

-- Filtros 
filtrarDeudores :: [(String, Bool)] -> [String]
filtrarDeudores t = nub (map (\(nombre,_) -> nombre) deudores) where 
  deudores = filter (\(alumno, adeuda) -> adeuda == True) t

main :: IO ()
main = do
    input <- getArgs -- lista de argumentos

    -- Ordenar entrada para el read
    let tmp = borrarPrimerChar input
    let inputLimpio = borrarComas tmp
    let tuplas = leerLista inputLimpio
    -- putStrLn $ "Input: " ++ show (tuplas)
    putStrLn "Usuarios que adeudan libros: "
    putStrLn $ show (filtrarDeudores tuplas)

    