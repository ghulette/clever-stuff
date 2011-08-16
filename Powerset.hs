import Control.Monad (filterM)

powerSet :: [a] -> [[a]]
powerSet = filterM (const [True, False])

main = do
  print $ powerSet [1,3,5]
