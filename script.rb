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

    Instance method update(move, field) will update the board_status array based on the field and a x or o
    Instance method reset will empty contents of a board_status array

    ----------------------------------------------------------------------------------------------------------

    Define a class Game that will initialize the board and will contain a loop for a game to be played.
    It will also initialize both players.
    Instance method play will contain all the neccessary logic for the game to be played from a terminal.

    ----------------------------------------------------------------------------------------------------------

    Define a class Player that will initialize the players and contain methods that players need to play tic tac toe.
    Also it will initialize a players' symbol (x or o)

    ----------------------------------------------------------------------------------------------------------
=end

class Game
    attr_accessor :board, :player_one, :player_two

    def initialize
        @board = Board.new
        @player_one = Player.new
        @player_two = Player.new
    end
end

class Player
    attr_accessor :name, :symbol

    def initialize(name = "Unknown player")
        @name = name
        @symbol = symbol
    end
end

class Board
    attr_reader :board_status
    
    def initialize
        @board_status = []
    end

    def update(move, field)
        @board_status[field] = move
    end

    def reset 
        @board_status = []
    end

    def to_s
        puts " #{@board_status[0]} | #{@board_status[1]} | #{board_status[2]}"
        puts "----------"
        puts " #{@board_status[3]} | #{@board_status[4]} | #{board_status[5]}"
        puts "----------"
        puts " #{@board_status[6]} | #{@board_status[7]} | #{@board_status[8]}"
        puts
    end
end

game = Game.new