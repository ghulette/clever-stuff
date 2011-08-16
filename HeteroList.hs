{-# LANGUAGE ExistentialQuantification #-}

-- Using existential quantification to build lists of heterogeneous data.

data Box = forall a . Show a => Box a

instance Show Box where
  show (Box x) = show x

heteroList :: [Box]
heteroList = [Box (), Box 5, Box True]

main :: IO ()
main = do
  mapM_ print heteroList
