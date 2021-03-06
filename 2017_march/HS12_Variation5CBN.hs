-- Non-deterministic choice
module HS12_Variation5CBN where
  
import Prelude hiding (lookup)

----------------
-- List Monad
----------------
type L a = [a]

unitL   :: a -> L a
unitL a = [a]

bindL       :: L a -> (a -> L b) -> L b
m `bindL` k = [b | a <- m, b <- k a]

zeroL :: L a
zeroL = []

plusL       :: L a -> L a -> L a
l `plusL` m = l ++ m

showL m = show [ showval a | a <- m]

----------------
-- Datatypes
----------------
type Name = String

data Term = Var Name
          | Con Int
          | Add Term Term
          | Lam Name Term
          | App Term Term
          -- new for the ND monad
          | Fail
          | Amb Term Term
          
data Value = Wrong
           | Num Int
           | Fun (L Value -> L Value)
           
type Environment = [(Name, L Value)]

----------------
-- Interpreter
----------------
showval        :: Value -> String
showval Wrong   = "<wrong>"
showval (Num i) = show i
showval (Fun f) = "<function>"

interp            :: Term -> Environment -> L Value
interp (Var x) e   = lookup x e
interp (Con i) e   = unitL (Num i)
interp (Add u v) e = interp u e `bindL` (\a ->
                     interp v e `bindL` (\b ->
                     add a b))
interp (Lam x v) e = unitL (Fun (\a -> interp v ((x,a):e)))
interp (App t u) e = interp t e `bindL` (\f ->
                     apply f (interp u e))
-- new for the ND monad
interp Fail e      = zeroL
interp (Amb u v) e = interp u e `plusL` interp v e


lookup :: Name -> Environment -> L Value
lookup x [] = unitL Wrong
lookup x ((y,n):e) = if x==y then n else lookup x e

add :: Value -> Value -> L Value
add (Num i) (Num j) = unitL (Num (i+j))
add a b = unitL Wrong

apply :: Value -> L Value -> L Value
apply (Fun h) m = h m
apply f m = unitL Wrong

----------------
-- Test
----------------
test :: Term -> String
test t = showL (interp t [])

termL = (App (Lam "x" (Add (Var "x") (Var "x")))
        (Amb (Con 1) (Con 2)))