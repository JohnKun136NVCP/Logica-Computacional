-- Definición del tipo Prop
data Prop = Var String       -- Variables proposicionales
          | No Prop          -- Negación
          | Prop :& Prop     -- Conjunción
          | Prop :| Prop     -- Disyunción
          deriving (Show, Eq)

-- Función para generar valores de verdad para una sola variable
truth :: String -> [(String, Bool)]
truth s = [(s, True), (s, False)]

-- Función para generar todas las combinaciones de valores de verdad para una lista de variables
truths :: [String] -> [[(String, Bool)]]
truths [] = [[]]
truths (s:ss) = [ t:ts | t <- truth s, ts <- truths ss ]

-- Función para buscar el valor de una variable en la asignación de verdad
lookupVar :: String -> [(String, Bool)] -> Bool
lookupVar x env = case lookup x env of
                    Just v  -> v
                    Nothing -> error ("Variable " ++ x ++ " no encontrada")

-- Función para evaluar una proposición y mostrar pasos intermedios (Ya no hay necesidad de una función para eliminar duplicados)
variables :: Prop -> [(String, Bool)] -> [(Prop, Bool)]
variables (Var x) env = [(Var x, lookupVar x env)]
variables (No p) env = let steps = variables p env
                           result = not (snd (last steps))
                       in steps ++ [(No p, result)]
variables (p :& q) env = let stepsP = variables p env
                             stepsQ = variables q env
                             result = (snd (last stepsP)) && (snd (last stepsQ))
                         in stepsP ++ stepsQ ++ [(p :& q, result)]
variables (p :| q) env = let stepsP = variables p env
                             stepsQ = variables q env
                             result = (snd (last stepsP)) || (snd (last stepsQ))
                         in stepsP ++ stepsQ ++ [(p :| q, result)]

-- Lista de variables
symbols :: [String]
symbols = ["p", "q"]

-- Generar la tabla de verdad
truthTable :: [[(String, Bool)]]
truthTable = truths symbols

-- Función para evaluar una proposición para todas las asignaciones de verdad y mostrar pasos
evalTableWithSteps :: Prop -> [[[(Prop, Bool)]]]
evalTableWithSteps prop = [ [variables prop env] | env <- truthTable ]

-- Ejemplo de proposición 1
exampleProp1 :: Prop
exampleProp1 = ((Var "p") :| (Var "q")) :|  (Var "p")

-- Evaluar el ejemplo de proposición 1 con pasos
resultTableWithSteps1 :: [[[(Prop, Bool)]]]
resultTableWithSteps1 = evalTableWithSteps exampleProp1


-- Imprimir el resultado final
main :: IO ()
main = do
    putStrLn "Evaluación de la proposición 1:"
    mapM_ print resultTableWithSteps1
