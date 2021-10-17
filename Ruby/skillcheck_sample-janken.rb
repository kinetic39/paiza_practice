#
# 大きい値を返却する関数
#
# @param [Numeric] a
# @param [Numeric] b
#
# @return [Numeric] より大きい値
#
def max(a, b)
  a > b ? a : b
end

#
# 小さい値を返却する関数
#
# @param [Numeric] a
# @param [Numeric] b
#
# @return [Numeric] より小さい値
#
def min(a, b)
  a < b ? a : b
end

n, m = gets.split.map(&:to_i)
s = gets.chomp

s_g = s.count('G')
s_c = s.count('C')
s_p = s.count('P')

# 最大勝利数
win_max = 0

(m / 5).downto(0) do |pa|
  ch = (m - 5 * pa) / 2
  gu = n - pa - ch

  break if gu.negative?
  next if m != 5 * pa + 2 * ch

  win_max = max(win_max, min(s_c, gu) + min(s_p, ch) + min(s_g, pa))
end

puts win_max
