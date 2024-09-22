import Data.List (intersect)

-- Definición del tipo Prop
data Prop = Var String       -- Variables proposicionales
          | No Prop          -- Negación
          | Prop :& Prop     -- Conjunción
          | Prop :| Prop     -- Disyunción
          | Prop :-> Prop    -- Implicación
          deriving (Show, Eq)

-- Definición del tipo Secuente
data Secuente = Secuente [Prop] [Prop]
              deriving (Show, Eq)

-- Función para recolectar todas las variables de una proposición
variables :: Prop -> [String]
variables (Var x) = [x]
variables (No p) = variables p
variables (p1 :& p2) = variables p1 ++ variables p2
variables (p1 :| p2) = variables p1 ++ variables p2
variables (p1 :-> p2) = variables p1 ++ variables p2

-- Función para determinar si un secuente es inicial
secuenteInicial :: Secuente -> Bool
secuenteInicial (Secuente izq der) = not (null (izq `intersect` der))

-- Regla para la conjunción en el lado izquierdo
ruleAndLeft :: Prop -> Secuente -> [Secuente]
ruleAndLeft (a :& b) (Secuente gamma delta) = [Secuente (a:gamma) delta, Secuente (b:gamma) delta]
ruleAndLeft _ secuente = [secuente]  -- Caso por defecto

-- Regla para la disyunción en el lado izquierdo
ruleOrLeft :: Prop -> Secuente -> [Secuente]
ruleOrLeft (a :| b) (Secuente gamma delta) = [Secuente (a:gamma) delta, Secuente (b:gamma) delta]
ruleOrLeft _ secuente = [secuente]  -- Caso por defecto

-- Regla para la implicación en el lado izquierdo
ruleImpLeft :: Prop -> Secuente -> [Secuente]
ruleImpLeft (a :-> b) (Secuente gamma delta) = [Secuente gamma (a:delta), Secuente (b:gamma) delta]
ruleImpLeft _ secuente = [secuente]  -- Caso por defecto

-- Función principal
main :: IO ()
main = do
    let secuente1 = Secuente [Var "p" :& Var "q"] [Var "p"]
    let secuente2 = Secuente [Var "p" :| Var "q"] [Var "r"]
    let secuente3 = Secuente [Var "p" :-> Var "q"] [Var "q"]

    print (ruleAndLeft (Var "p" :& Var "q") secuente1)
    print (ruleOrLeft (Var "p" :| Var "q") secuente2)
    print (ruleImpLeft (Var "p" :-> Var "q") secuente3)
