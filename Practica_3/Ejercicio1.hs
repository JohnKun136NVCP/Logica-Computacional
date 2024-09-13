-- Definición del tipo Prop
data Prop = Var String       -- Variables proposicionales
          | No Prop          -- Negación
          | Prop :& Prop     -- Conjunción
          | Prop :| Prop     -- Disyunción
          deriving (Show, Eq)

-- Proposicion
form1 :: Prop
form1 = ((Var "p") :& (Var "q")) :| (No (Var "r")) :& ((Var "s") :| No (Var "t"))

-- Function para recolectar todas las variables
variables :: Prop -> [String]
variables (Var x) = [x]
variables (No p) = variables p
variables (p1 :& p2) = variables p1 ++ variables p2
variables (p1 :| p2) = variables p1 ++ variables p2

main :: IO ()
main = do
    let var = variables form1
    print var
