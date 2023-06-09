=begin    
    Building a tic-tac-toe game on the command line where two human players can play against each other 
    and the board is displayed in between turns.

    It involves a couple of players, a simple board, checking for victory in a game loop.

    ----------------------------------------------------------------------------------------------------------

    
    To start things off, define a class Board that wil hold methods that are needed for the game to be played.
    Instance variable size will hold an array of x and o values that users played
    Board is initialized.
    Method #to_s is overridden with a nice display of users' moves. 

    Positions on the board are numbered from 0 to 8

    Instance method update(move, field) will update the board_status array based on the field and a x or o.

    Instance variable full? will check if all fields are filled and it will mean that it's a draw

    ----------------------------------------------------------------------------------------------------------

    Define a class Game that will initialize the board and will contain a loop for a game to be played.
    It will also initialize both players and will have a winner variable.

    Instance method over? will check if there are 3 consecutive symbols
    It will check if a board has 3 same symbols on any of those arrays
    According to that, it will be able to declare a winner.

    Instance method play will contain all the logic neccessary for the game to actualy be played.
    Users will first be asked what their name is and they will be given a random symbol (x or o) each.
    Then, until the game's not over, users will be prompted to enter their symbol into the field they want

    When user inputs a place where he wants to put their symbol, there is a check for a TypeError in begin..rescue block

    ----------------------------------------------------------------------------------------------------------

    Define a class Player that will initialize a player with his name.
    Also it will initialize a players' symbol (x or o).
    There is also a turn variable that is true if the player is on the move

    ----------------------------------------------------------------------------------------------------------

    Create a module called TicTacToe that will contain all the helper methods and classes

    ----------------------------------------------------------------------------------------------------------
=end

require 'pry-byebug'

module TicTacToe
    WINS = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8],  # Horizontal wins
        [0, 3, 6], [1, 4, 7], [2, 5, 8],  # Vertical wins
        [0, 4, 8], [2, 4, 6]              # Diagonal wins
    ]
    OPTIONS = ['x', 'o']
    FIELDS = {top_left: 0,
        top: 1, 
        top_right: 2, 
        left: 3, 
        middle: 4, 
        right: 5, 
        bottom_left: 6, 
        bottom: 7, 
        bottom_right: 8
    }    

    class Board
        attr_reader :board_status
        
        def initialize
            @board_status = []
        end
    
        def update(move, field)
            board_status[field] = move
        end
    
        def filled?
            board_status.compact.length == 9 ? true : false
        end
    
        def to_s
            puts " #{board_status[0]} | #{board_status[1]} | #{board_status[2]}"
            puts "----------"
            puts " #{board_status[3]} | #{board_status[4]} | #{board_status[5]}"
            puts "----------"
            puts " #{board_status[6]} | #{board_status[7]} | #{board_status[8]}"
            puts
        end
    end

    class Player
        attr_accessor :name, :symbol, :turn
    
        def initialize(name = "Unknown player")
            @name = name
            @symbol = symbol
            @turn = false
        end
    end

    def check_win(line, board, player, winner)
        if line.all? {|field| board.board_status[field] == player.symbol}
            @winner = player
            true
        end
    end

    def intro(player_one, player_two)
        puts "Player 1, please enter your name:"
        player_one.name = gets.chomp
        puts "Player 2, please enter your name:"
        player_two.name = gets.chomp
        puts ""
        puts "Welcome #{player_one.name} and #{player_two.name}. You will now recieve your symbols."
        puts ""

        player_one.symbol = OPTIONS.sample
        player_two.symbol = (OPTIONS.select {|symbol| symbol != player_one.symbol}).join  # select the one who the other player didn't get
    
        puts "#{player_one.name}'s symbol is #{player_one.symbol}"
        puts "#{player_two.name}'s symbol is #{player_two.symbol}"
        puts ""

        puts "When prompted, please enter one of the following commands: "
        puts FIELDS.keys.join("   ")
        puts ""
        sleep(2)
    end

    def check_symbol(player_one, player_two)
        if player_one.symbol == 'x'
            player_one.turn = true
        else 
            player_two.turn = true
        end
    end

    def play_round(player, other_player, board)
        # Check whose turn it is and change it after the user played his move
        # Ensure the user's input is legit     
        puts "Do your thing #{player.name}: "
        field = gets.chomp.to_sym
        begin
            if board.board_status[FIELDS[field]] != 'x' && board.board_status[FIELDS[field]] != 'o'
                board.update(player.symbol, FIELDS[field]) 
            else
                puts ""
                puts "That field is already filled!!!"
                puts ""
                return
            end
        rescue TypeError
            puts ""
            puts "Please enter one of the acceptable commands: "
            puts FIELDS.keys.join("   ")
            puts ""
            return
        else
            player.turn = false
            other_player.turn = true
        end   
    end

    def finish_game(winner, board)
        puts ""
        if winner
            puts "And the winner is..... #{winner.name} with a #{winner.symbol} symbol"
        else 
            puts "It's a draw"
        end
        board.to_s
    end

    class Game
        attr_reader :board, :player_one, :player_two, :winner
    
        def initialize
            @board = Board.new
            @player_one = Player.new
            @player_two = Player.new
            @winner = nil
        end
    
        def over?
            WINS.any? do |line| 
                check_win(line, board, player_one, winner) || check_win(line, board, player_two, winner)
            end
        end
    
        def play 
            intro(player_one, player_two)
    
            # x always goes first
            check_symbol(player_one, player_two)
    
            until over? || board.filled?
                board.to_s
    
                if player_one.turn 
                    play_round(player_one, player_two, board)
                elsif player_two.turn
                    play_round(player_two,player_one, board)
                end
            end
    
            finish_game(winner, board)
        end
    end
end

include TicTacToe

game = Game.new
game.play()