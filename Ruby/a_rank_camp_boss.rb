# 自分の得意な言語で
# Let's チャレンジ！！

#
# 地図クラス
#
class Map

    #
    # 地図クラスのイニシャライザ
    #
    # @param [Array] map 地図情報
    # @param [Integer] h 地図の縦
    # @param [Integer] w 地図の横
    #
    def initialize(map, h, w)
        #地図
        @@map = map

        #地図の縦
        @@h = h

        #地図の横
        @@w = w
    end

    #
    # sの初期位置を調べるメソッド
    #
    # @param [String] s 初期位置を調べる文字
    # @return [Array / false] [x座標, y座標, s]/false(探索失敗)
    #
    def self.where_orig_pos(s='*')
        @@h.times do |y|
            @@w.times do |x|
                if @@map[y][x] == s
                    return [x, y, s]
                end
            end
        end
        return false
    end

    #
    # 座標(x,y)が到達可能かを返すメソッド
    #
    # @param [Integer] x x座標
    # @param [Integer] y y座標
    #
    # @return [Boolean] 到達可能(true)/不可能(false)
    #
    def self.is_able_to_stand?(x,y)
        if x < 0
            return false
        elsif y < 0
            return false
        elsif @@w <= x
            return false
        elsif @@h <= y
            return false
        elsif @@map[y][x] == '*'
            return false
        else
            return @@map[y][x] == '.'
        end
    end

    #
    # 通り抜けた地点を地図に記すメソッド
    #
    # @param [Integer] x x座標
    # @param [Integer] y y座標
    # @param [String] s 地図に記す文字
    #
    def self.update_history(x,y,s)
        @@map[y][x] = s
    end

    #
    # 地図を表示するメソッド
    # （デバッグ用）
    #
    def self.show_map()
        @@h.times do |i|
            puts @@map[i].join('')
        end
        printf("\n")
    end

    #
    # 勝者を表示するメソッド
    #
    def self.show_winner()
        a = 0
        b = 0
        @@h.times do |i|
            @@w.times do |j|
                if @@map[i][j] == 'A'
                    a += 1
                elsif @@map[i][j] == 'B'
                    b += 1
                end
            end
        end

        printf("%d %d\n",a,b)

        if a>b
            puts 'A'
        elsif a<b
            puts 'B'
        else
            puts 'DRAW'
        end
    end
end


###########################
#   ここからメイン処理     #
###########################

vals = gets.split(' ')

#盤面行数
h = vals[0].to_i

#盤面列数
w = vals[1].to_i

#手番のプレーヤー
player = gets.chomp

#後攻の初手はまだか？
is_1ststep_unfinished = true

#盤面文字
s = []

#盤面読み込み
h.times do |i|
    s[i] = gets.chomp.split(//)
end

#盤面生成
Map.new(s, h, w)

#探索キュー
queue = []

#先攻の初期位置を追加する
queue.push(Map.where_orig_pos(player))

loop do

    if queue.length == 0
        break
    end

    #着目したい位置とプレーヤー
    pos = queue.shift

    #北
    if Map.is_able_to_stand?(pos[0],pos[1]-1)
        Map.update_history(pos[0], pos[1]-1, pos[2])
        queue.push([pos[0], pos[1]-1, pos[2]])
    end

    #南
    if Map.is_able_to_stand?(pos[0],pos[1]+1)
        Map.update_history(pos[0], pos[1]+1, pos[2])
        queue.push([pos[0], pos[1]+1, pos[2]])
    end

    #東
    if Map.is_able_to_stand?(pos[0]+1,pos[1])
        Map.update_history(pos[0]+1, pos[1] , pos[2])
        queue.push([pos[0]+1, pos[1], pos[2]])
    end

    #西
    if Map.is_able_to_stand?(pos[0]-1,pos[1])
        Map.update_history(pos[0]-1, pos[1], pos[2])
        queue.push([pos[0]-1, pos[1] , pos[2]])
    end

    #後攻の初手が未完了の場合、後攻の手番を挿入
    if is_1ststep_unfinished

        #選手交代
        if player == 'A'
            player = 'B'
        else
            player = 'A'
        end

        queue.unshift(Map.where_orig_pos(player))
        is_1ststep_unfinished = false
    end
end

Map.show_winner()