-- Output
module HS07_Variation4 where
  
import Prelude hiding (lookup)

----------------
-- Output Monad
----------------
type O a = (String, a)

unitO       :: a -> O a
unitO a     = ("", a)

bindO       :: O a -> (a -> O b) -> O b
m `bindO` k = let (r,a) = m
                  (s,b) = k a
              in  (r++s, b)

showO       :: O Value -> String
showO (s,a) = "Output: " ++ s ++ " Value: " ++ showval a

-- Looks familiar?
outO  :: Value -> O ()
outO a = (showval a ++ "; ", ())

-- putStr :: String -> IO ()

----------------
-- Datatypes
----------------
type Name = String

data Term = Var Name
          | Con Int
          | Add Term Term
          | Lam Name Term
          | App Term Term
          -- new for the output monad
          | Out Term
          
data Value = Wrong
           | Num Int
           | Fun (Value -> O Value)
           
type Environment = [(Name, Value)]

----------------
-- Interpreter
----------------
showval         :: Value -> String
showval Wrong   = "<wrong>"
showval (Num i) = show i
showval (Fun f) = "<function>"

interp             :: Term -> Environment -> O Value
interp (Var x) e   = lookup x e
interp (Con i) e   = unitO (Num i)
interp (Add u v) e = interp u e `bindO` (\a ->
                     interp v e `bindO` (\b ->
                     add a b))
interp (Lam x v) e = unitO (Fun (\a -> interp v ((x,a):e)))
interp (App t u) e = interp t e `bindO` (\f ->
                     interp u e `bindO` (\a ->
                     apply f a))
-- new for the output monad                     
interp (Out u) e   = interp u e `bindO` (\a ->
                     outO a     `bindO` (\() -> unitO a))

lookup             :: Name -> Environment -> O Value
lookup x []        = unitO Wrong
lookup x ((y,b):e) = if x==y then unitO b else lookup x e

add                :: Value -> Value -> O Value
add (Num i) (Num j) = unitO (Num (i+j))
add a b             = unitO Wrong

apply          :: Value -> Value -> O Value
apply (Fun k) a = k a
apply f a       = unitO Wrong

----------------
-- Test
----------------
test  :: Term -> String
test t = showO (interp t [])

termO = (Add (Out (Con 41)) (Out (Con 1)))

term0 = (App (Lam "x" (Add (Var "x") (Var "x")))
             (Add (Con 10) (Con 11)))