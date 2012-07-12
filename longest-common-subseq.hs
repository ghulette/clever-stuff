import Data.Array

data Dir = N | W | NW deriving Eq

lcsTrace :: [a] -> Array (Int,Int) Dir -> Int -> Int -> [a]
lcsTrace _ _ 0 _ = []
lcsTrace _ _ _ 0 = []
lcsTrace x d i j | d!(i,j) == NW = (head x) : lcsTrace (tail x) d (i-1) (j-1)
lcsTrace x d i j | d!(i,j) == N = lcsTrace (tail x) d (i-1) j
lcsTrace x d i j | d!(i,j) == W = lcsTrace x d i (j-1)

lcs :: Eq a => [a] -> [a] -> [a]
lcs x y = reverse (lcsTrace (reverse x) d m n)
  where m = length x
        n = length y
        ix = \f ixs -> zip ixs (map f ixs)
        c = array ((0,0),(m,n)) (ix cf [(i,j) | i <- [0..m], j <- [0..n]])
        cf = \ix -> case ix of
          (0,_) -> 0
          (_,0) -> 0
          (i,j) | x!!(i-1)  == y!!(j-1)  -> c!(i-1,j-1) + 1
          (i,j) | c!(i-1,j) >= c!(i,j-1) -> c!(i-1,j)
          (i,j) | otherwise              -> c!(i,j-1)
        d = array ((0,0),(m,n)) (ix df [(i,j) | i <- [0..m], j <- [0..n]])
        df = \ix -> case ix of
          (0,_) -> N
          (_,0) -> N
          (i,j) | x!!(i-1)  == y!!(j-1)  -> NW
          (i,j) | c!(i-1,j) >= c!(i,j-1) -> N
          (i,j) | otherwise              -> W

main :: IO ()
main = do
  putStrLn $ lcs "the quick brown fox" "quickly quickly"
