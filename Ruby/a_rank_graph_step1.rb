n, m = gets.split.map(&:to_i)
a = []
b = []

g = Array.new(n) do
  Array.new(n, 0)
end

m.times do |i|
  a[i], b[i] = gets.split.map(&:to_i)

  g[a[i] - 1][b[i] - 1] = 1
  g[b[i] - 1][a[i] - 1] = 1
end

n.times do |i|
  result_line = g[i].map(&:to_s).join('')
  puts result_line
end
