n = gets.to_i

g = Array.new(n).map { Array.new(n, 0) }
(n - 1).times do
  a, b = gets.split.map(&:to_i)
  g[a - 1][b - 1] = 1
  g[b - 1][a - 1] = 1
end

apple = n.times.map { gets.to_i }

having = 0
from = 1
visited = Array.new(n, false)
while true
  having += apple[from - 1]
  puts having

  visited[from - 1] = true

  to = 0
  g[from - 1].each.with_index do |val, i|
    next if val == 0 || visited[i]
    to = i + 1
  end

  break if to == 0

  from = to
end