-- Definición del tipo Prop
data Prop = Var String       -- Variables proposicionales
          | No Prop          -- Negación
          | Prop :& Prop     -- Conjunción
          | Prop :| Prop     -- Disyunción
          deriving (Show, Eq)

-- Proposicion
formula :: Prop
-- (P and Q) or (No R) and (S or (No T))
formula = ((Var "p") :& (Var "q")) :| (No (Var "r")) :& ((Var "s") :| No (Var "t"))

-- Si se desea evaluar

interpretacion :: Prop -> [(String, Bool)] -> Bool
interpretacion (Var x) env = case lookup x env of
                     Just v  -> v
                     Nothing -> error ("")
interpretacion (No p) env = not (interpretacion p env)
interpretacion (p :& q) env = (interpretacion p env) && (interpretacion q env)
interpretacion (p :| q) env = (interpretacion p env) || (interpretacion q env)


main :: IO ()
main = do
    print(formula)
    print $ interpretacion formula [("p",False),("q",False),("r",False),("s",True),("t",False)]
