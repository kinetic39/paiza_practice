# 写経


# n:頂点, m:辺の数

n, m = gets.split.map(&:to_i)



# 隣接行列

g = Array.new(n).map { Array.new(n, 0) }

m.times do

  a, b = gets.split.map(&:to_i)

  g[a - 1][b - 1] = 1

  g[b - 1][a - 1] = 1

end



queue = [1]

visited = Array.new(n, false)

until queue.empty?

  from = queue.shift

  visited[from - 1] = true



  g[from - 1].each.with_index do |val, to|

    next if val == 0 || visited[to]



    queue.push to + 1

  end

end



link = true

visited.each { |v| link &&= v }



if link

  puts 'YES'

else

  puts 'NO'

end

