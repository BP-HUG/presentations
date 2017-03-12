-- State
module HS11_Variation3CBN where

import Prelude hiding (lookup)

----------------
-- State Monad
----------------
type State = Int

type S a = State -> (a, State)

unitS   :: a -> S a
unitS a = \s0 -> (a, s0)

bindS       :: S a -> (a -> S b) -> S b
m `bindS` k = \s0 -> let (a, s1) = m s0
                         (b, s2) = k a s1
                     in  (b, s2)

showS m = let (a, s1) = m 0
          in  "Value: " ++ showval a ++ "; " ++
              "Count: " ++ show s1

tickS :: S ()
tickS = \s -> ((), s+1)

fetchS :: S State
fetchS = \s -> (s, s)  

----------------
-- Datatypes
----------------
type Name = String


data Term = Var Name
          | Con Int
          | Add Term Term
          | Lam Name Term
          | App Term Term
          | Count
          
data Value = Wrong
           | Num Int
           -- Changed M Value
           | Fun (S Value -> S Value)
           
type Environment = [(Name, S Value)]

----------------
-- Interpreter
----------------
showval         :: Value -> String
showval Wrong   = "<wrong>"
showval (Num i) = show i
showval (Fun f) = "<function>"

-- Changed E Value and bindE
interp             :: Term -> Environment -> S Value
interp (Var x) e   = lookup x e
interp (Con i) e   = unitS (Num i)
interp (Add u v) e = interp u e `bindS` (\a ->
                     interp v e `bindS` (\b ->
                     add a b))
interp (Lam x v) e = unitS (Fun (\m -> interp v ((x,m):e)))
interp (App t u) e = interp t e `bindS` (\f ->
                     apply f (interp u e))
interp Count e     = fetchS `bindS` (\i -> unitS (Num i))

lookup             :: Name -> Environment -> S Value
lookup x []        = unitS Wrong
lookup x ((y,n):e) = if x==y then n else lookup x e

add                 :: Value -> Value -> S Value
add (Num i) (Num j) = tickS `bindS` (\() -> unitS (Num (i+j)))
add a b             = unitS Wrong

apply           :: Value -> S Value -> S Value
apply (Fun h) m = tickS `bindS` (\() -> h m)
apply h m       = unitS Wrong

----------------
-- Test
----------------
test   :: Term -> String
test t = showS (interp t [])

termSCBN = (App (Lam "x" (Add (Var "x") (Var "x")))
                (Add (Con 10) (Con 11)))