# 自分の得意な言語で
# Let's チャレンジ！！

#
# 動くヘビクラス
#
class Snake

    #
    # イニシャライザ
    #
    # @param [Integer] x 初期位置のx座標
    # @param [Integer] y 初期位置のy座標
    # @param [String] d 初期の向き（'N'or'E'or'W'or'S'）
    #
    def initialize(x,y,d)
        #現在のx座標
        @cur_x = x

        #現在のy座標
        @cur_y = y

        #現在向いている方角
        @cur_news = d

        Map.update_history(@cur_x, @cur_y)
    end

    #
    # 回れ右or回れ左して、正面の方角を更新する
    #
    # @param [String] lr 左右（'L'/'R'）
    #
    def turn(lr)
        if @cur_news == 'N'
            if lr == 'L'
                @cur_news = 'W'
            else
                @cur_news = 'E'
            end
        elsif @cur_news == 'E'
            if lr == 'L'
                @cur_news = 'N'
            else
                @cur_news = 'S'
            end
        elsif @cur_news == 'W'
            if lr == 'L'
                @cur_news = 'S'
            else
                @cur_news = 'N'
            end
        else #S
            if lr == 'L'
                @cur_news = 'E'
            else
                @cur_news = 'W'
            end
        end
    end


    #
    # 一歩前進できれば進み、できなければ止まる
    #
    # @return [Boolean] 進んだ(true)/止まった(false)
    #
    def go_forward()
        if is_able_to_go_forward?()
            case @cur_news
            when 'N'
                @cur_y -= 1
            when 'E'
                @cur_x += 1
            when 'W'
                @cur_x -= 1
            else
                @cur_y += 1
            end
            Map.update_history(@cur_x, @cur_y)
            return true
        else
            return false
        end
    end

    #
    # 左か右に進み、現在の場所を表示する。
    #
    # @param [String] lr 左右（'L'/'R'）：デフォルトはnil
    #
    # @return [Boolean] 進んだ(true)/止まった(false)
    #
    def go_in(lr=nil)
        if lr != nil
            turn(lr)
        end
        return go_forward()
    end

    def is_able_to_go_forward?()
        case @cur_news
        when 'N'
            return Map.is_able_to_stand?(@cur_x, @cur_y - 1)
        when 'E'
            return Map.is_able_to_stand?(@cur_x + 1, @cur_y)
        when 'W'
            return Map.is_able_to_stand?(@cur_x - 1, @cur_y)
        else
            return Map.is_able_to_stand?(@cur_x, @cur_y + 1)
        end
    end

    private  :turn, :is_able_to_go_forward?
end

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
    #
    def self.update_history(x,y)
        @@map[y][x] = '*'
    end

    #
    # 地図を表示するメソッド
    #
    def self.show_map()
        @@h.times do |i|
            puts @@map[i].join('')
        end
    end
end

###########################
#   ここからメイン処理      #
###########################

vals = gets.split(' ')

#盤面行数
h = vals[0].to_i

#盤面列数
w = vals[1].to_i


#命令数
num_inst = vals[4].to_i

#盤面文字
s = []

#盤面読み込み
h.times do |i|
    s[i] = gets.chomp.split(//)
end
Map.new(s, h, w)

#向きを変える時刻
t = []

#転換する向き
d = []

#命令読み込み
num_inst.times do |i|
    input_lines = gets.split(' ')
    t[i] = input_lines[0].to_i
    d[i] = input_lines[1]
end

#時刻
step = 0

#命令配列の添字
count = 0

#ヘビ
snake = Snake.new(vals[3].to_i, vals[2].to_i, 'N')

#ヘビ、動きます！
loop do
    if step >= 100
        break
    elsif step == t[count]
        if !snake.go_in(d[count])
            break
        end

        if count < num_inst
            count += 1
        end
    else
        if !snake.go_forward()
            break
        end
    end
    step += 1
end

Map.show_map()
