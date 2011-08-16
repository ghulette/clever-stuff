-- An infinite stream of Fibonacci numbers

fibs :: [Int]
fibs = 1:1:fib 1 1
  where fib x1 x2 = let x3 = x1+x2 in x3:(fib x2 x3)
        
main :: IO ()
main = do
  print $ take 10 fibs
  