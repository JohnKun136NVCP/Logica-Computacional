import Data.List (intersect)

-- Definición del tipo Prop
data Prop = Var String       -- Variables proposicionales
          | No Prop          -- Negación
          | Prop :& Prop     -- Conjunción
          | Prop :| Prop     -- Disyunción
          | Prop :-> Prop    -- Implicación
          deriving (Show, Eq)

-- Definición del tipo de dato Secuente
data Secuente = Secuente [Prop] [Prop]
    deriving (Show, Eq)

-- Función para verificar si es un secuente inicial
secuenteInicial :: Secuente -> Bool
secuenteInicial (Secuente izq der) = not (null (izq `intersect` der))

-- Función recorrer
recorrer :: [a] -> [a]
recorrer [] = []
recorrer (x:xs) = xs ++ [x]

-- Reglas de inferencia
ruleAndLeft :: Prop -> Prop -> Secuente -> [Secuente]
ruleAndLeft a b (Secuente gamma delta) = [Secuente (a:gamma) delta, Secuente (b:gamma) delta]

ruleOrLeft :: Prop -> Prop -> Secuente -> [Secuente]
ruleOrLeft a b (Secuente gamma delta) = [Secuente (a:gamma) delta, Secuente (b:gamma) delta]

ruleImpLeft :: Prop -> Prop -> Secuente -> [Secuente]
ruleImpLeft a b (Secuente gamma delta) = [Secuente gamma (a:delta), Secuente (b:gamma) delta]

ruleAndRight :: Prop -> Prop -> Secuente -> [Secuente]
ruleAndRight a b (Secuente gamma delta) = [Secuente gamma (a:delta), Secuente gamma (b:delta)]

ruleOrRight :: Prop -> Prop -> Secuente -> [Secuente]
ruleOrRight a b (Secuente gamma delta) = [Secuente gamma (a:b:delta)]

ruleImpRight :: Prop -> Prop -> Secuente -> [Secuente]
ruleImpRight a b (Secuente gamma delta) = [Secuente (a:gamma) (b:delta)]

ruleNegLeft :: Prop -> Secuente -> [Secuente]
ruleNegLeft p (Secuente gamma delta) = [Secuente gamma (p:delta)]

ruleNegRight :: Prop -> Secuente -> [Secuente]
ruleNegRight p (Secuente gamma delta) = [Secuente (p:gamma) delta]

-- Función auxiliar esDerivableAux
esDerivableAux :: [Secuente] -> Bool
esDerivableAux [] = False
esDerivableAux (s:secs)
  | secuenteInicial s = True
  | otherwise = esDerivableAux (secs ++ aplicarReglas s)

-- Función esDerivable
esDerivable :: Secuente -> Bool
esDerivable sec = esDerivableAux [sec]

-- Función aplicarReglas
aplicarReglas :: Secuente -> [Secuente]
aplicarReglas (Secuente izq der) = aplicarReglasIzq izq ++ aplicarReglasDer der

-- Función aplicarReglasIzq
aplicarReglasIzq :: [Prop] -> [Secuente]
aplicarReglasIzq [] = []
aplicarReglasIzq (x:xs) = case x of
  No p -> ruleNegLeft p (Secuente xs [])
  p :& q -> ruleAndLeft p q (Secuente xs [])
  p :| q -> ruleOrLeft p q (Secuente xs [])
  p :-> q -> ruleImpLeft p q (Secuente xs [])
  _ -> aplicarReglasIzq xs

-- Función aplicarReglasDer
aplicarReglasDer :: [Prop] -> [Secuente]
aplicarReglasDer [] = []
aplicarReglasDer (x:xs) = case x of
  No p -> ruleNegRight p (Secuente [] xs)
  p :& q -> ruleAndRight p q (Secuente [] xs)
  p :| q -> ruleOrRight p q (Secuente [] xs)
  p :-> q -> ruleImpRight p q (Secuente [] xs)
  _ -> aplicarReglasDer xs

-- Función para mostrar el árbol de derivación
mostrarArbol :: Secuente -> IO ()
mostrarArbol secuente = imprimirArbol secuente 0

imprimirArbol :: Secuente -> Int -> IO ()
imprimirArbol sec depth = do
    putStrLn (replicate depth ' ' ++ show sec)
    if secuenteInicial sec
        then putStrLn (replicate depth ' ' ++ "Secuente Inicial")
        else mapM_ (\s -> imprimirArbol s (depth + 2)) (aplicarReglas sec)

-- Función main para probar las fórmulas especificadas
main :: IO ()
main = do
    let a = Var "A"
    let b = Var "B"

    let formula1 = a :-> (b :-> (a :& b))
    let formula2 = No (No a) :-> a
    let formula3 = (a :-> b) :-> ((a :-> No b) :-> No a)

    putStrLn "Árbol de derivación para formula1:"
    mostrarArbol (Secuente [] [formula1])

    putStrLn "\nÁrbol de derivación para formula2:"
    mostrarArbol (Secuente [] [formula2])

    putStrLn "\nÁrbol de derivación para formula3:"
    mostrarArbol (Secuente [] [formula3])
