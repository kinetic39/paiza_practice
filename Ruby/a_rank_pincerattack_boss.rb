# 自分の得意な言語で
# Let's チャレンジ！！

#
# 盤面クラス
#
class Board

    #
    # 盤面クラスのイニシャライザ
    #
    # @param [Array] board 盤面情報
    # @param [Integer] h 盤面の縦
    # @param [Integer] w 盤面の横
    #
    def initialize(board, h, w)
        #盤面
        @@board = board

        #盤面の縦
        @@h = h

        #盤面の横
        @@w = w
    end

    #
    # sの初期位置を調べるメソッド
    #
    # @param [String] s 初期位置を調べる文字
    # @return [Array / false] [x座標, y座標, s]/false(探索失敗)
    #
    def self.where_orig_pos(s='!')
        @@h.times do |y|
            @@w.times do |x|
                if @@board[y][x] == s
                    return [x, y, s]
                end
            end
        end
        return false
    end

    #
    # 座標(x,y)が裏返し可能か調べて，裏返しを実行するメソッド
    #
    # @param [Integer] x x座標
    # @param [Integer] y y座標
    # @param [String] d (キーボードFキーから見た)方向
    # @param [String] player プレイヤー名
    #
    # @return [Boolean] 到達可能(true)/不可能(false)
    #
    def self.turn_over?(x,y,d,player)
        if x < 0
            return false
        elsif y < 0
            return false
        elsif @@w <= x
            return false
        elsif @@h <= y
            return false
        elsif @@board[y][x] == '#'
            return false
        elsif @@board[y][x] == player.to_s
            return true
        else
            #x軸変位
            dx = 0

            #y軸変位
            dy = 0

            case d
            when 'r'
                dy = -1
            when 'v'
                dy = 1
            when 'g'
                dx = 1
            when 'd'
                dx = -1
            when 't'
                dx = 1
                dy = -1
            when 'b'
                dx = 1
                dy = 1
            when 'e'
                dx = -1
                dy = -1
            when 'c'
                dx = -1
                dy = 1
            end
            
            if self.turn_over?(x+dx, y+dy, d, player)
                self.update_board(x, y, player)
                return true
            end
        end
        return false
    end

    #
    # 通り抜けた地点を盤面に記すメソッド
    #
    # @param [Integer] x x座標
    # @param [Integer] y y座標
    # @param [String] s 盤面に記す文字
    #
    def self.update_board(x,y,s)
        @@board[y][x] = s.to_s
    end

    #
    # 盤面を表示するメソッド
    #
    def self.show_board()
        @@h.times do |i|
            puts @@board[i].join('')
        end
        printf("\n")
    end
end

###########################
#   ここからメイン処理     #
###########################

#H W Y X入力
vals = gets.split(' ').map!{ 
    |v| v.to_i
} 

#盤面行数
h = vals[0]

#盤面列数
w = vals[1]

#石を置く回数
n = vals[3]

#盤面文字
s = []

#盤面読み込み
h.times do |i|
    s[i] = gets.chomp.split(//)
end

#盤面生成
Board.new(s, h, w)

n.times do
    #石を置く場所を入力(player, y,x)
    put_pos = gets.chomp.split(' ').map!{
        |input| input.to_i
    }

    #指定箇所に石を置く
    Board.update_board(put_pos[2], put_pos[1], put_pos[0])
    
    #各縦横方向，裏返してみる
    Board.turn_over?(put_pos[2]+1, put_pos[1], 'g', put_pos[0])
    Board.turn_over?(put_pos[2]-1, put_pos[1], 'd', put_pos[0])
    Board.turn_over?(put_pos[2], put_pos[1]+1, 'v', put_pos[0])
    Board.turn_over?(put_pos[2], put_pos[1]-1, 'r', put_pos[0])
    
    
    #各ナナメ方向，裏返してみる
    Board.turn_over?(put_pos[2]+1, put_pos[1]-1, 't', put_pos[0])
    Board.turn_over?(put_pos[2]-1, put_pos[1]-1, 'e', put_pos[0])
    Board.turn_over?(put_pos[2]+1, put_pos[1]+1, 'b', put_pos[0])
    Board.turn_over?(put_pos[2]-1, put_pos[1]+1, 'c', put_pos[0])
end

#盤面表示
Board.show_board
