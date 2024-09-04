-- Definición del tipo Prop
data Prop = Var String       -- Variables proposicionales
          | No Prop          -- Negación
          | Prop :& Prop     -- Conjunción
          | Prop :| Prop     -- Disyunción
          deriving (Show, Eq)

p1 :: Prop
p1 = Var "P"

p2 :: Prop
p2 = Var "Q"
-- (¬P ^ Q) ∨ (P ∨ ¬Q) = True
form1 :: Prop
form1 = (No p1 :& p2) :| (p1 :| No p2)
-- (¬P ^ Q) ∧ (P ∨ ¬Q) = False
form2 :: Prop
form2 = (No p1 :& p2) :& (p1 :| No p2)
-- (¬P ^ ¬Q) ∨ ¬(¬P ^ ¬Q) = True
form3 :: Prop
form3 = (No p1 :& No p2) :| No(No p1 :& No p2)

-- Si se desea evaluar 

eval :: Prop -> [(String, Bool)] -> Bool
eval (Var x) env = case lookup x env of
                     Just v  -> v
                     Nothing -> error ("")
eval (No p) env = not (eval p env)
eval (p :& q) env = (eval p env) && (eval q env)
eval (p :| q) env = (eval p env) || (eval q env)


main :: IO ()
main = do 
    print(form1)
    let values = [("P",True),("Q",True)]
    print $ eval form1 values
    print(form2)
    print $ eval form2 values
    print(form3)
    let values2 = [("P",True),("Q",False)]
    print $ eval form3 values2
