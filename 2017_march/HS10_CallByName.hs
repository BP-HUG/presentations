module HS10_CallByName where

import Prelude hiding (lookup)

----------------
-- Monad
----------------
type M a = a

unitM   :: a -> M a
unitM a = a

bindM       :: M a -> (a -> M b) -> M b
a `bindM` k = k a

showM   :: M Value -> String
showM a = showval a

----------------
-- Datatypes
----------------
type Name = String

data Term = Var Name
          | Con Int
          | Add Term Term
          | Lam Name Term
          | App Term Term
          
data Value = Wrong
           | Num Int
           -- (Value -> M Value) -> (M Value -> M Value)
           | Fun (M Value -> M Value)

-- (Name, Value) -> (Name, M Value)
type Environment = [(Name, M Value)]

----------------
-- Interpreter
----------------
showval         :: Value -> String
showval Wrong   = "<wrong>"
showval (Num i) = show i
showval (Fun f) = "<function>"

interp             :: Term -> Environment -> M Value
interp (Var x) e   = lookup x e
interp (Con i) e   = unitM (Num i)
interp (Add u v) e = interp u e `bindM` (\a ->
                     interp v e `bindM` (\b ->
                     add a b))
-- interp (Lam x v) e = unitM (Fun (\a -> interp v ((x,a):e)))
interp (Lam x v) e = unitM (Fun (\m -> interp v ((x,m):e)))
--interp (App t u) e = interp t e `bindM` (\f ->
--                     interp u e `bindM` (\a ->
--                     apply f a))
interp (App t u) e = interp t e `bindM` (\f ->
                     apply f (interp u e))

lookup             :: Name -> Environment -> M Value
lookup x []        = unitM Wrong
-- lookup x ((y,b):e) = if x==y then unitM b else lookup x e
lookup x ((y,n):e) = if x==y then n else lookup x e

add                 :: Value -> Value -> M Value
add (Num i) (Num j) = unitM (Num (i+j))
add a b             = unitM Wrong

--apply         :: Value -> Value -> M Value
apply           :: Value -> M Value -> M Value
--apply (Fun k) a = k a
apply (Fun h) m = h m
--apply f a       = unitM Wrong
apply f m       = unitM Wrong

test   :: Term -> String
test t = showM (interp t [])

termName = (App (Lam "x" (Add (Var "x") (Var "x"))) (Con 1))