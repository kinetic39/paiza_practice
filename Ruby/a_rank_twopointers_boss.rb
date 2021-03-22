# 自分の得意な言語で
# Let's チャレンジ！！

#入力値
input_line = gets.chomp.split(" ").map!{
    |x| x.to_i
}

#数列 a の要素数
n = input_line[0]

#条件に使う整数
k = input_line[1]

#数列 a
a = gets.chomp.split(" ").map!{
    |i| i.to_i
}

#積
product = 1

#最短の長さ
min_len = n

n.times do |i|

    #数列i番目からスタート
    product = a[i]

    #スタートの段階でkを超えるor最小の長さが1の場合
    if product >= k || min_len == 1
        #最小の長さを1に更新して、探索処理を終了する
        min_len = 1
        break
    end

    (n-i-1).times do |j|

        #積が0なら次の数列の部分列へ
        if product==0
            break
        else
            #積を更新
            product *= a[i + j + 1]

            #条件を満たした場合、その数列の長さが最短であれば、最短の長さを更新する
            if product >= k
                if j + 2 < min_len
                    min_len = j + 2
                end
                break
            end
        end
    end
end

puts min_len