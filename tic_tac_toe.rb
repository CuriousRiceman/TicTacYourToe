class Board 
    attr_reader :board

    def initialize()
        @board = %w(1 2 3 4 5 6 7 8 9)
    end

    def display()
        puts "Current board: "
        puts "#{@board[0]} | #{@board[1]} | #{@board[2]}"
        puts "---------"
        puts "#{@board[3]} | #{@board[4]} | #{@board[5]}"
        puts "---------"
        puts "#{@board[6]} | #{@board[7]} | #{@board[8]}"
    end 

    def update_board(player, position, symbol)
        puts "#{player} chose position #{position}"
        @board[position - 1] = symbol
        display
    end

    def check_board(current_player, turn)
        win = [
            [0, 1, 2],  # Top row
            [3, 4, 5],  # Middle row
            [6, 7, 8],  # Bottom row
            [0, 3, 6],  # Left column
            [1, 4, 7],  # Middle column
            [2, 5, 8],  # Right column
            [0, 4, 8],  # Diagonal from top-left to bottom-right
            [2, 4, 6]   # Diagonal from top-right to bottom-left
        ]

        win.each do |combo|
            if board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]]
                puts "#{current_player} wins!"
                return true
            end
        end
        
        if turn == 8
            puts "It's a tie!"
        end

        false
    end
end

class Player
    attr_reader :player1, :player2, :player1Symbol, :player2Symbol, :move, :board

    PLAYERS = ["Player 1", "Player 2"]
    VALID_SYMBOLS = ['X', 'O']

    def initialize()
        @player1Symbol = choose_symbol
        @player2Symbol = choose_symbol
        @player1 = PLAYERS[0]
        @player2 = PLAYERS[1]
    end

    def choose_symbol
        loop do
            puts "Pick a symbol ('X' or 'O'):"
            player_symbol = gets.chomp.upcase
        
            if VALID_SYMBOLS.include?(player_symbol)
            puts "You chose '#{player_symbol}'."
            return player_symbol
            else
            puts "Invalid input! Please enter either 'X' or 'O'."
            end
        end
    end
      
    def make_moves()
        puts "Choose a position (1-9):"
        position = gets.chomp.to_i
        position
    end

end

class Game

    def play()
        board = Board.new
        player = Player.new
        board.display

        9.times do |turn|
            if turn % 2 == 0
                current_player = player.player1
                symbol = player.player1Symbol
            else
                current_player = player.player2
                symbol = player.player2Symbol
            end
            position = player.make_moves
            if (1..9).cover?(position)
                board.update_board(current_player, position, symbol)
                win_or_naw = board.check_board(current_player, turn)
                if win_or_naw == true
                    break
                end
            else
                puts "Invalid input! Please enter a number between 1 and 9."
                position = player.make_moves
            end
        end
        play_again?
    end

    def play_again?()
        print "Do you want to play again? (yes/no): "
        response = gets.chomp.downcase
        if response == "yes"
            play()
        else
            puts "Thanks for playing!"
        end
    end

end

game = Game.new
game.play()