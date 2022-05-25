# require_relative "board.rb"
require_relative "hand.rb"
require "colorize"

class Player 

    attr_reader :board, :name
    attr_accessor :hand, :chips, :big_blind, :current_bet, :all_in, :active

    def initialize(name, password, board, chips = 1000)
        @name = name
        @board = board 
        @password = password
        @hand = Hand.new(@board) # reset for each round 
        @chips =chips  
        @big_blind = false #reset for each round 
        @active = true #reset for each round
        @all_in = false # reset for each round 
        @current_bet = 0 #keeps track of current bet in a turn #reset for each turn
    end

    def reset
        @hand = Hand.new(@board)
        @big_blind = false
        @active = true
        @all_in = false
        @current_bet = 0
    end

    def get_move
        begin
            print "\33c\e[3J" #this is essential "clear" except more powerful. flushes the screen
            puts "#{@name}, please enter your password: "
            passw = gets.chomp

            if passw == @password
                print "\33c\e[3J"
                puts "The Flop".center(60) + "   " "Total Chips".center(24)
                bf = Array.new(9, "") 

                @board.flop.each do |card|
                    cp = card.card_picture
                    (0..8).each do |i|
                        bf[i] += cp[i]
                    end
                end
                
                (5 - board.flop.length).times do
                    bf[0] += "┌─────────┐ "
                    bf[1] += '│░░░░░░░░░│ '
                    bf[2] += '│░░░░░░░░░│ '
                    bf[3] += '│░░░░░░░░░│ '
                    bf[4] += '│░░░░░░░░░│ '
                    bf[5] += '│░░░░░░░░░│ '
                    bf[6] += '│░░░░░░░░░│ '
                    bf[7] += '│░░░░░░░░░│ '
                    bf[8] += '└─────────┘ '
                end

                (0..8).each do |line|
                    bf[line] += "│ " 
                end

                str_a = Array.new(9, "                    ")
                board.players.each_with_index do |player, i|
                    if board.players.length <= 3
                        index = (i * 2) + 1
                    else
                        index = i + 1
                    end
                    if player.chips > 0
                        str_a[index] = "#{player.name.ljust(12)}" + "   " + "#{player.chips.to_s.rjust(5)}" 
                        # if player == self
                        #     str_a[index] = "#{player.name.ljust(12)}" + "   " + "#{player.chips.to_s.rjust(5)}" 
                        # else
                        #     str_a[index] = "#{player.name.ljust(12)}" + "   " + "#{player.chips.to_s.rjust(5)}" 
                        # end
                    else
                        str_a[index] = "#{player.name.ljust(12)}" + "   " + "💀".rjust(5)
                    end
                end


                bf[0] += "┌────────────────────┐ "
                bf[1] += "│#{str_a[1]}│ "  # use two {} one for char, one for space or char
                bf[2] += "│#{str_a[2]}│ "
                bf[3] += "│#{str_a[3]}│ "
                bf[4] += "│#{str_a[4]}│ "
                bf[5] += "│#{str_a[5]}│ "
                bf[6] += "│#{str_a[6]}│ "
                bf[7] += "│#{str_a[7]}│ "
                bf[8] += "└────────────────────┘ "

                (0..8).each do |line|
                    puts bf[line]
                end 
                puts
                puts "#{name}'s Hand".center(23) + "  " + "Current Bets".center(34).underline + "POT SIZE: $#{@board.main_pot}".center(29).colorize(:green)

                f = Array.new(9, "") 
                hand.small_hand.each do |card|
                    cp = card.card_picture
                    (0..8).each do |i|
                        f[i] += cp[i]
                    end
                end

                bet_arr = Array.new(9, " " * 35)

                board.players.each_with_index do |player, i|
                    if board.players.length <= 3
                        index = (i * 2) + 1
                    else
                        index = i + 1
                    end
                    if player.active
                        if player.big_blind
                            bet_arr[index] = " #{player.name.ljust(20)}".colorize(:light_green) + "#{player.current_bet.to_s.rjust(14)}" 
                        else
                            bet_arr[index] = " #{player.name.ljust(20)}"+ "#{player.current_bet.to_s.rjust(14)}" 
                        end
                    else
                        bet_arr[index] = " #{player.name.ljust(20)}"+ "FOLDED".rjust(14)
                    end
                end

                (0..8).each do |line|
                    f[line] += bet_arr[line] + "      "
                end
                f[0] += "MINIMUM BET: $#{@board.minimum_bet}".colorize(:red).center(31)
                f[2] += "Commands".underline.center(31)
                f[4] += " " + "bet".rjust(6) + "  " + "fold".ljust(7)
                f[5] += " " + "call".rjust(6) + "  " + "check".ljust(7)
                f[6] += " " + "all-in".rjust(6) + "  " + "raise".ljust(7)

                (0..8).each do |line|
                    puts f[line]
                end





                # puts "Mainpot is #{@board.main_pot}"
                # puts "Your have #{@chips} chips left"
                # puts "Current minimum bet is #{@board.minimum_bet}"
                # @board.players.each do |player|
                #     puts "#{player.name}'s current bet: #{player.current_bet}"
                # end
                # puts "List of command are:\n 'fold',\n'check',\n 'call',\n 'bet num',\n'raiseto num',\n'allin'"
            
                puts
                puts
                puts "-"*95

            else
                raise StandardError.new("wrong password")
            end

        rescue StandardError=>e
            puts e
            retry
        end


        begin
            puts "#{@name}, please enter a command:"
            player_input = gets.chomp.split
            move, num = player_input
            
            case move.downcase
            when "allin", "a", "all-in", "all"
                self.go_all_in
            when "bet", "b"
                # raise StandardError.new("Must enter input with bet!") if num == nil
                while(num == nil)
                    puts "Please enter the amount you'd like to bet, or -1 if you want to change your mind: "
                    num = gets.chomp
                    raise StandardError.new("User requested to attempt other command") if num.to_i < 0
                end
                num = num.to_i
                self.bet(num)
            when "call"
                self.call
            when "raiseto", "r", "raise"
                #raise StandardError.new("Must enter input with raiseto!") if num == nil
                while(num == nil)
                    puts "Please enter the amount you'd like to raise to, or -1 if you want to change your mind: "
                    num = gets.chomp
                    raise StandardError.new("User requested to attempt other command") if num.to_i < 0
                end
                num = num.to_i
                self.raiseto(num)
            when "fold", "f"
                self.fold
            when "check"
                self.check
            when "exit"
                #add exiting the game
            else
                raise StandardError=> "Wrong command, please choose one of the valid commands"
            end
        rescue StandardError=>e 
            puts "Error Occurred: #{e}"
            puts "Please try again"
            puts
            retry
        end
    end 

    def check
        raise StandardError.new("you cannot check") if @current_bet < @board.minimum_bet
        @board.count += 1
    end

    def go_all_in
        #player stay active until the end 
        # player use all their chips 

        match_bet = @board.minimum_bet - @current_bet

        @board.main_pot += @chips  
        if @chips > match_bet
            @board.minimum_bet = @chips + @current_bet
            @board.count = 1
        else
            @board.count += 1
        end
        @current_bet += @chips
        @chips = 0  # need to revise base on other players
        @all_in = true  
    end

    def bet(num)
        p "bet"
        # only use this for post flop
        raise StandardError.new("you cannot use this action") if @board.players.any? {|player| player.current_bet > 0}
        raise StandardError.new("you have to bet at least # {@board.start_bet}") if num < @board.start_bet
        raise StandardError.new("you don't have enough money") if num >= chips
        @board.main_pot += num
        @current_bet += num
        @chips -= num
        @board.minimum_bet = num
        @board.count += 1
    end

    def raiseto(num)
        raise StandardError.new("did not enter a valid number to raise to") if num == nil
        bet = num - @current_bet
        raise StandardError.new("your bet is lower than the current bet of #{@board.minimum_bet}!") if bet < @board.minimum_bet #?
        raise StandardError.new("you dont have enough money") if bet >= @chips
        raise StandardError.new("you cannot raise") if @board.minimum_bet <= 0 
        @board.main_pot += bet
        @current_bet += bet
        @chips -= bet
        @board.minimum_bet = num
        @board.count = 1 # reset the board count to 1 when someone raises
    end

    def call
        bet = @board.minimum_bet - @current_bet
        raise StandardError.new("you dont have enough money") if bet >= @chips
        raise StandardError.new("you cannot call") if @current_bet == @board.minimum_bet
        @board.main_pot += bet
        @current_bet += bet
        @chips -= bet
        @board.count += 1
    end

    def fold
        # player become inactiv
        # player forego their hands
        self.active = false
        self.current_bet = 0
    end

    # def blind_move
    #     if @chips < @board.start_bet
    #         self.go_all_in
    #     else 
    #         @board.main_pot += @board.start_bet
    #         @current_bet += @board.start_bet
    #         @chips -= @board.start_bet
    #         get_move
    #     end
    # end

    private
    attr_accessor :password


end 