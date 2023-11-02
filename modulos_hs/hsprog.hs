import System.Environment
import Data.Maybe

--Funcion para filtro por titulo:
filtroPorTitulo :: String -> [(String, String, String, Int, Int)] -> Maybe [(String, String, String, Int, Int)]
filtroPorTitulo _ [] = Just []  -- Caso de lista vacia
filtroPorTitulo titulo libros
    |any (\(t, _, _, _, _) -> t == titulo) libros = Just (filter (\(t, a, au, p, an) -> t == titulo) libros)
    |otherwise = Nothing

--Funcion para filtro por Area:
filtroPorArea :: String -> [(String, String, String, Int, Int)] -> Maybe [(String, String, String, Int, Int)]
filtroPorArea _ [] = Just []  -- Caso de lista vacía
filtroPorArea area libros
    | any (\(_, a, _, _, _) -> a == area) libros = Just (filter (\(_, a, _, _, _) -> a == area) libros)
    | otherwise = Nothing

--Funcion para filtro por Autor:
filtroPorAutor :: String -> [(String, String, String, Int, Int)] -> Maybe [(String, String, String, Int, Int)]
filtroPorAutor _ [] = Just []  -- Caso de lista vacía
filtroPorAutor autor libros
    | any (\(_, _, a, _, _) -> a == autor) libros = Just (filter (\(_, _, a, _, _) -> a == autor) libros)
    | otherwise = Nothing
    
--Funcion para filtro por Paginas:

--Funcion para filtro Year:
filtroYear :: Int -> [(String, String, String, Int, Int)] -> Maybe [(String, String, String, Int, Int)]
filtroYear _ [] = Just []  -- Caso de lista vacía
filtroYear year libros
    | any (\(_, _, _, _, y) -> y == year) libros = Just (filter (\(_, _, _, _, y) -> y == year) libros)
    | otherwise = Nothing

main :: IO()
main = do
    x <- getArgs
    print x

    -- TEST FILTROS
    let listaDeLibros = [ ("Libro 1", "Ciencia", "Autor 1", 200, 2020), ("Libro 2", "Historia", "Autor 2", 300, 2019), ("Libro 3", "Tecnología", "Autor 3", 250, 2021), ("Libro 4", "Ciencia", "Autor 1", 150, 2018)]
    let resultado1 = filtroPorTitulo "Libro 1" listaDeLibros
    let resultado2 = filtroPorArea "Ciencia" listaDeLibros
    let resultado3 = filtroPorAutor "Autor 1" listaDeLibros
    --let resultado4 = aun no acabo
    let resultado5 = filtroYear 2020 listaDeLibros

    --Imprimir filtro Titulo:
    case resultado1 of
        Nothing -> putStrLn ""
        Just libros -> print libros

    --Imprimir filtro Area:
    case resultado2 of
        Nothing -> putStrLn ""
        Just libros -> print libros

    --Imprimir filtro Autor:
    case resultado3 of
        Nothing -> putStrLn ""
        Just libros -> print libros

    --Imprimir filtro Paginas:

    --Imprimir filtro Año:
    case resultado5 of
        Nothing -> putStrLn ""
        Just libros -> print libros