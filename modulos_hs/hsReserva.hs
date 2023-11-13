import System.Environment
import Data.List (nub)

-- Funciones para obtener limpiar el input por terminal
borrarPrimerChar :: [String] -> [String]
borrarPrimerChar [] = []
borrarPrimerChar (x:xs) = (tail x) : xs

borrarComas :: [String] -> [String]
borrarComas = map init

convertirATupla :: String -> (Bool, [String])
convertirATupla s = read s :: (Bool, [String])

leerLista :: [String] -> [(Bool, [String])]
leerLista = map convertirATupla

-- Filtros 
filtrarPorReserva :: [(Bool, [String])] -> [String]
filtrarPorReserva t = elimRedundancia (map (\(_,listaLibros) -> listaLibros) reservados) where 
  reservados = filter (\(reservado, xs) -> reservado == True) t

elimRedundancia :: [[String]] -> [String]
elimRedundancia = nub . concat

main :: IO ()
main = do
    input <- getArgs -- lista de argumentos

    -- Ordenar entrada para el read
    let tmp = borrarPrimerChar input
    let inputLimpio = borrarComas tmp
    let tuplas = leerLista inputLimpio
    -- putStrLn $ "Input: " ++ show (tuplas)
    putStrLn "Libros ya reservados: "
    putStrLn $ show (filtrarPorReserva tuplas)

    