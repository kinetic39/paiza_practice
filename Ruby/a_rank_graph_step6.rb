n = gets.to_i

# 始点
a = []

# 終点
b = []

# 隣接行列
g = Array.new(n) do
  Array.new(n, 0)
end

(n - 1).times do |i|
    a[i], b[i] = gets.split.map(&:to_i)

    g[a[i] - 1][b[i] - 1] = 1
    g[b[i] - 1][a[i] - 1] = 1
end

apple = []
n.times do |i|
    apple[i] = gets.to_i
end

path = []
path[0] = 1

#リンゴの合計数
sum = apple[path[0] - 1]

n.times do |i|
    puts sum
    j = 0

    # 次の地点を探索
    n.times do
        break if g[path[i] - 1][j] == 1
        j += 1
    end

    next unless i < n - 1

    # 次の地点登録
    path[i + 1] = j + 1
    sum += apple[path [i + 1] - 1]

    # 次の地点から，今の地点に帰らないようにする
    g[path[i] - 1][path[i + 1] - 1] = 0
    g[path[i + 1] - 1][path[i] - 1] = 0
end
