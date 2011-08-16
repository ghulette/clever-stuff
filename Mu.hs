-- From Mark Jones' paper "Functional Programming with Overloading and 
-- Higher-Order Polymorphism"

import Prelude hiding (succ)

-- This would be prettier with GADTs

data Mu f = In (f (Mu f))

out :: Mu f -> f (Mu f)
out (In x) = x

-- Catamorphism
cata :: Functor f => (f a -> a) -> Mu f -> a
cata phi = phi . fmap (cata phi) . out

-- Anamorphism
ana :: Functor f => (a -> f a) -> a -> Mu f
ana psi = In . fmap (ana psi) . psi

-- Natural numbers

type Nat = Mu NatF
data NatF s = Zero | Succ s

instance Functor NatF where
  fmap f Zero = Zero
  fmap f (Succ x) = Succ (f x)

zero :: Nat
zero = In Zero

succ :: Nat -> Nat
succ x = In (Succ x)

add :: Nat -> Nat -> Nat
add n m = cata (\fa -> case fa of
                         Zero -> m
                         Succ x -> succ x) n
