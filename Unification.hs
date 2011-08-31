-- Simple implementation of syntactic unification
-- http://ale.cs.toronto.edu/docs/ref/ale_trale_ref/ale_trale_ref-node4.html

import Data.List (intercalate)
import Control.Monad (guard)

type Name = String


-- Terms

data Term = Var Name
          | Func Name [Term]
          deriving Eq

instance Show Term where
  show (Var x) = "'" ++ x
  show (Func f []) = f
  show (Func f ts) = f ++ "(" ++ s ++ ")"
    where s = intercalate "," (map show ts)

atom :: Name -> Term
atom x = Func x []

func :: Name -> [Term] -> Term
func = Func

var :: Name -> Term
var = Var

occurs :: Name -> Term -> Bool
occurs x (Var y) | x == y = True
occurs x (Var y) = False
occurs x (Func _ ts) = any (occurs x) ts


-- Environments

type Env = [(Name,Term)]

empty :: Env
empty = []

substitute :: Env -> Term -> Term
substitute e t = foldl sub t e
  where sub (Var y)     (x,t) | x == y = t
        sub (Var y)     (x,_) = Var y
        sub (Func f ts) p = Func f (map (flip sub p) ts)

extend :: Name -> Term -> Env -> Env
extend x t = (:) (x,t)


-- Unification 

unify :: Term -> Term -> Maybe Env
unify t1 t2 = unify' [(t1,t2)] empty

unify' :: [(Term,Term)] -> Env -> Maybe Env
unify' [] e = Just e
unify' ((t1,t2):ts) e = case (substitute e t1,substitute e t2) of
  (Func f fs,Func g gs) -> do
    guard (f == g)
    guard (length fs == length gs)
    unify' ((zip fs gs) ++ ts) e
  (Var x,Var y) | x == y -> unify' ts e
  (Var x,t) -> do
    guard (not $ occurs x t)
    unify' ts (extend x t e)
  (t,Var x) -> do
    guard (not $ occurs x t)
    unify' ts (extend x t e)


-- Example

main :: IO ()
main = do
  let t1 = func "f" [var "x", func "g" [atom "a",atom "c"]]
  let t2 = func "f" [atom "a",func "g" [var "x",atom "c"]]
  print t1
  print t2
  print $ unify t1 t2
