-- Definición de árbol binario
data BinaryTree bt = Null | Node bt (BinaryTree bt) (BinaryTree bt)
    deriving (Show,Eq)

-- Función para contar no. de Nodos
count :: BinaryTree bt -> Int
count Null = 0
count (Node _ left right) = 1 + count left + count right

-- Función para profundidad
height :: BinaryTree bt -> Int
height Null = 0 -- Cuando tiene un solo nodo o es vacío
height (Node _ left right) = 1 + max(height left) (height right)

-- Maxima de Nodos por altura h
-- h = 2^(h+1) - 1
maxNodes :: Int -> Int
maxNodes h = 2^(h + 1) -1

-- Un ejemplo para comprobar todos los puntos anteriores y también la maxima altura

btree :: BinaryTree Int
btree = Node 1 (Node 2 Null Null) (Node 3 (Node 4 Null Null) Null)

-- No. Nodos
nodes = count btree
-- altura
heightTree = height btree
-- Maxima de Nodos
maxNodesTree = maxNodes 8

main :: IO ()
main = do
    
    print(btree) 
    print(nodes) -- 4 Nodos. a)
    print(heightTree) -- 3. b)
    print(maxNodesTree) --511. c)

