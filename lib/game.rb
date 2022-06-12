$: << "."
require_relative "board.rb"
require_relative "player.rb"
require "yaml"

class Game
    attr_reader :num_players, :board

    def initialize
        puts "New game (n) or load game(l)?"
        inp = gets.chomp.downcase
        if (inp == "n" || inp[0..2] == "new")
            puts "Please enter the name of the file you'd like to save to"
            @myfilename = gets.chomp
            if (@myfilename.length < 6 || @myfilename[-5..-1] != ".yaml")
                @myfilename += ".yaml"
            end
            if(File.exists?("games/" + @myfilename))
                raise IOError.new("File Already exists")
            end
            start
        elsif (inp == "l" || inp[0..3] == "load")
            puts "Please enter the file name you'd like to load: "
            file_name = gets.chomp
            if (file_name.length < 6 || file_name[-5..-1] != ".yaml")
                file_name += ".yaml"
            end
            f = File.read("games/" + file_name)
            @board = YAML::load(f)
            @num_players = @board.num_players
            print "\33c\e[3J"
            puts "LOADING..."
            sleep(0.8)
            print "\33c\e[3J"
            puts "Game has successfully loaded!"
            sleep(1.7)
            play
        else
            puts "Please enter valid option next time..."
            exit
        end
    end

    def start
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
            print "\33c\e[3J"
            encrypted_pass = BCrypt::Password.create(passw)
            player = Player.new(p_name, encrypted_pass, @board, earnings)
            # @players << player
            @board.players << player
            
            i += 1
        end
        play
    end

    def play
        until @board.players.length <= 1
            @board.play_round
            saved_board = @board.to_yaml
            File.open("games/" + @myfilename, "w") { |f| f.write(saved_board) }
        end
    end

end

g = Game.new