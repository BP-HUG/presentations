-- Error Monad with Position
module HS05_Variation2 where

import Prelude hiding (lookup)

------------------------
-- Error Position Monad
------------------------
type Position = Int

pos0 :: Position
pos0 = 0

type P a = Position -> E a

unitP a  = \p -> unitE a
errorP s = \p -> errorE (show p ++ ": " ++ s)

m `bindP` k = \p -> m p `bindE` (\x -> k x p)

showP m = showE (m pos0)

resetP     :: Position -> P x -> P x
resetP q m = \p -> m q

----------------
-- Error Monad
----------------
data E a = Success a
         | Error String

unitE a  = Success a
errorE s = Error s

(Success a) `bindE` k = k a
(Error s) `bindE` k   = Error s

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
          | At Position Term
          
data Value = Wrong
           | Num Int
           -- Changed E Value
           | Fun (Value -> P Value)
           
type Environment = [(Name, Value)]

----------------
-- Interpreter
----------------
showval         :: Value -> String
showval Wrong   = "<wrong>"
showval (Num i) = show i
showval (Fun f) = "<function>"

-- Changed E Value and bindE
interp             :: Term -> Environment -> P Value
interp (Var x) e   = lookup x e
interp (Con i) e   = unitP (Num i)
interp (Add u v) e = interp u e `bindP` (\a ->
                     interp v e `bindP` (\b ->
                     add a b))
interp (Lam x v) e = unitP (Fun (\a -> interp v ((x,a):e)))
interp (App t u) e = interp t e `bindP` (\f ->
                     interp u e `bindP` (\a ->
                     apply f a))
interp (At p t) e  = resetP p (interp t e)

lookup             :: Name -> Environment -> P Value
lookup x []        = errorP ("unbound variable: " ++ x)
lookup x ((y,b):e) = if x==y then unitP b else lookup x e

add                 :: Value -> Value -> P Value
add (Num i) (Num j) = unitP (Num (i+j))
add a b             = errorP ("should be numbers: " ++ showval a ++
                      ", " ++ showval b)

apply           :: Value -> Value -> P Value
apply (Fun k) a = k a
apply f a       = errorP ("should be function: " ++ showval f)

----------------
-- Test
----------------
test   :: Term -> String
test t = showP (interp t [])

termP = Add (Con 1) (At 42 (App (Con 2) (Con 3)))

termE = (At 2 (App (Var "x") (Con 2)))

term0 = (App (Lam "x" (Add (Var "x") (Var "x")))
             (Add (Con 10) (Con 11)))