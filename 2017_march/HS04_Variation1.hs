-- Error Monad
module HS04_Variation1 where

import Prelude hiding (lookup)

----------------
-- Error Monad
----------------
data E a = Success a
         | Error String

unitE a  = Success a
errorE s = Error s

(Success a) `bindE` k = k a
(Error s)   `bindE` k = Error s

showE (Success a) = "Success: " ++ showval a
showE (Error s)   = "Error: " ++ s

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
           -- Changed E Value
           | Fun (Value -> E Value)
           
type Environment = [(Name, Value)]

----------------
-- Interpreter
----------------
showval         :: Value -> String
showval Wrong   = "<wrong>"
showval (Num i) = show i
showval (Fun f) = "<function>"

-- Changed E Value and bindE
interp             :: Term -> Environment -> E Value
interp (Var x) e   = lookup x e
interp (Con i) e   = unitE (Num i)
interp (Add u v) e = interp u e `bindE` (\a ->
                     interp v e `bindE` (\b ->
                     add a b))
interp (Lam x v) e = unitE (Fun (\a -> interp v ((x,a):e)))
interp (App t u) e = interp t e `bindE` (\f ->
                     interp u e `bindE` (\a ->
                     apply f a))

lookup             :: Name -> Environment -> E Value
lookup x []        = errorE ("unbound variable: " ++ x)
lookup x ((y,b):e) = if x==y then unitE b else lookup x e

add                 :: Value -> Value -> E Value
add (Num i) (Num j) = unitE (Num (i+j))
add a b             = errorE ("should be numbers: " ++ showval a ++
                      ", " ++ showval b)

apply           :: Value -> Value -> E Value
apply (Fun k) a = k a
apply f a       = errorE ("should be function: " ++ showval f)

----------------
-- Test
----------------
test   :: Term -> String
test t = showE (interp t [])

term0 = (App (Lam "y" (Add (Var "x") (Var "x")))
             (Add (Con 10) (Con 11)))