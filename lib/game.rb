require_relative "board.rb"
require_relative "player.rb"

class Game
    attr_reader :num_players, :board, :players

    def initialize
        puts "How many players are playing?"
        @num_players = gets.chomp.to_i
        if num_players > 8 || num_players < 2
            raise IOError.new("Invalid Number of Players")
        end

        raise IOError.new("UI Currently only supports up to 6 players") if num_players > 6

        @board = Board.new(@num_players)

        # @players = [] #might not be needed, here JIC

        i = 0
        while i < @num_players
            system "clear"
            puts "Player #{i+1}, please enter your name: "
            p_name = gets.chomp
            p_name = p_name[0..11] if p_name.length > 12
            if p_name[0..1].downcase == "da" || p_name[0..3].downcase == "will" || p_name[0..6].downcase == "william" || p_name.downcase[0..6] == "frinxor"
                earnings = 500
            else
                earnings = 1000
            end
            puts "Please enter a short password"
            passw = gets.chomp
            puts "that's not short lol hope u can remember that" if passw.length > 5
            player = Player.new(p_name, passw, @board, earnings)
            # @players << player
            @board.players << player
            
            i += 1
        end
    end

    def play
        until @board.players.length <= 1
            @board.play_round
        end
        
    end

end

g = Game.new
g.play