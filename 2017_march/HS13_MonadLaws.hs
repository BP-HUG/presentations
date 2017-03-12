module HS13_MonadLaws where

----------------
-- Monad
----------------
type M a = a

unitM   :: a -> M a
unitM a = a

bindM       :: M a -> (a -> M b) -> M b
a `bindM` k = k a

----------------
-- Monad laws
----------------

----------------
-- Left unit
----------------

-- (unitM a) `bindM` k = k a

-- unitM a              :: a -> M a
-- bindM                :: M a -> (a -> M b) -> M b
-- (unitM a) `bindM` k  :: a -> M a -> (a -> M b) -> M b
-- k a                  :: a -> M a -> (a -> M b) -> M b

----------------
-- Rigth unit
----------------

-- m `bindM` unitM = m

-- unitM                :: _ -> M _
-- bindM                :: M a -> (a -> M b) -> M b
-- m `bindM` unitM      :: _ -> M _ -> (_ -> M _) -> M _
-- m                    :: _ -> M _ -> (_ -> M _) -> M _

----------------
-- Associativity
----------------

--    m ‘bindM‘ (\a -> (k a) ‘bindM‘ (\b -> h b))
-- = (m ‘bindM‘ (\a -> k a)) ‘bindM‘ (\b - h b)