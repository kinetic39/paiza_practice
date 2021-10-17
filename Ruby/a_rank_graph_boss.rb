# n:頂点の数, m:辺の数
n, m = gets.split.map(&:to_i)

# 訪れた形跡
ans = Array.new(n) do |_i|
  false
end

# 隣接行列
g = Array.new(n) do
  Array.new(n, 0)
end

m.times do |_i|
  a, b = gets.split.map(&:to_i)
  g[a - 1][b - 1] = 1
  g[b - 1][a - 1] = 1
end

# 探索キュー[from, to, 進んだ辺数, map]
queue = []

# 経路
path = []

# 最初の地点を追加する
queue.push([0, 1, 0, g])

loop do
  if queue.length == 0
    # 探す地点がないとき
    break
  end

  # 着目したい位置
  pos = queue.shift

  from = pos[1]

  ans[from - 1] = true

  # 次の地点toを探索
  1.upto(n) do |to|
    next unless pos[3][from - 1][to - 1] == 1

    next_pos3 = pos[3].dup
    next_pos3[from - 1][to - 1] = 0
    next_pos3[to - 1][from - 1] = 0
    queue.push([from, to, pos[2] + 1, next_pos3])
  end
end

# 繋がっているか
link = true

# すべて訪れたかチェック
ans.each do |v|
  link &&= v
end

if link

  puts 'YES'

else

  puts 'NO'

end
