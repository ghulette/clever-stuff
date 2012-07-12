#!/usr/bin/env ruby

def print_lcs(a,d,i,j)
  case
  when i == 0 || j == 0
    return ""
  when d[i][j] == :nw
    c = a[i-1]
    s = print_lcs(a,d,i-1,j-1)
    return s << c
  when d[i][j] == :n
    return print_lcs(a,d,i-1,j)
  when d[i][j] == :w
    return print_lcs(a,d,i,j-1)
  end
end

def match(a,b)
  m = a.length
  n = b.length
  c = Array.new(m+1) {Array.new(n+1)}
  d = Array.new(m+1) {Array.new(n+1)}
  for i in 0..m
    c[i][0] = 0
  end
  for j in 0..n
    c[0][j] = 0
  end
  for i in 1..m
    for j in 1..n
      if a[i-1] == b[j-1] then
        c[i][j] = c[i-1][j-1] + 1
        d[i][j] = :nw
      elsif c[i-1][j] >= c[i][j-1] then
        c[i][j] = c[i-1][j]
        d[i][j] = :n
      elsif c[i-1][j] < c[i][j-1] then
        c[i][j] = c[i][j-1]
        d[i][j] = :w
      end
    end
  end
  return print_lcs(a,d,m,n)
end

puts match("mellyellow","yellowfell")
