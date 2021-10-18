h, w = gets.split.map(&:to_i)

# 盤面
t = []

h.times do |i|
  t[i] = gets.split.map(&:to_i)
end

puts t[0][1] + t[1][1] + t[1][2] + t[0][2] + t[0][1]
