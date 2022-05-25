require "colorize"

class Card 

    SUITS = [:hearts, :clubs, :spades, :diamonds]
    TYPES = [:ace, :king,
    :queen, 
    :jack, 
    :ten, 
    :nine, 
    :eight,
    :seven,
    :six, 
    :five, 
    :four, 
    :three, 
    :two]

    attr_reader :type, :suit, :color

    def initialize(type, suit)
        @type = type
        @suit = suit
        if @suit == :clubs || @suit == :spades
            @color = :white
        else
            @color = :red
        end
    end

    def value
        case @type
            when :ace
                return 14
            when :king
                return 13
            when :queen
                return 12
            when :jack
                return 11
            when :ten
                return 10
            when :nine
                return 9
            when :eight
                return 8
            when :seven
                return 7
            when :six
                return 6
            when :five
                return 5
            when :four
                return 4
            when :three
                return 3
            when :two 
                return 2
        end
        raise StandardError("Unknown Card Type!")
        return nil
    end

    def type_s
        case @type
        when :ace
            return "A"
        when :king
            return "K"
        when :queen
            return "Q"
        when :jack
            return "J"
        else
            return value.to_s
        end
    end

    def suit_s
        case @suit
        when :spades
            return "♠"
        when :diamonds
            return "♦"
        when :hearts
            return "♥"
        when :clubs
            return "♣"
        else
            raise StandardError.new("Invalid Suit")
        end
    end

    def card_picture
        lines = Array.new
        lines[0] = "┌─────────┐ "
        lines[1] = "│#{type_s.ljust(2)}       │ "  # use two {} one for char, one for space or char
        lines[2] = "│         │ "
        lines[3] = "│         │ "
        lines[4] = "│    #{suit_s.colorize(color)}    │ "
        lines[5] = "│         │ "
        lines[6] = "│         │ "
        lines[7] = "│       #{type_s.rjust(2)}│ "
        lines[8] = "└─────────┘ "
        return lines
    end
    
    def self.all_types
        return TYPES
    end

    def self.all_suits
        return SUITS
    end

    def self.print_empty_cards
        # lines = Array.new
        # lines[0] = ['┌─────────┐ ┌─────────┐'],
        # lines[1] = ['│░░░░░░░░░│ │░░░░░░░░░│']
        # lines[2] = ['│░░░░░░░░░│ │░░░░░░░░░│']
        # lines[3] = ['│░░░░░░░░░│ │░░░░░░░░░│']
        # lines[4] = ['│░░░░░░░░░│ │░░░░░░░░░│']
        # lines[5] = ['│░░░░░░░░░│ │░░░░░░░░░│']
        # lines[6] = ['│░░░░░░░░░│ │░░░░░░░░░│']
        # lines[7] = ['│░░░░░░░░░│ │░░░░░░░░░│']
        # lines[8] = ['└─────────┘ └─────────┘']
        
        # lines.each do |l|
        #     puts l
        # end
        puts '┌─────────┐ ┌─────────┐'
        puts '│░░░░░░░░░│ │░░░░░░░░░│'
        puts '│░░░░░░░░░│ │░░░░░░░░░│'
        puts '│░░░░░░░░░│ │░░░░░░░░░│'
        puts '│░░░░░░░░░│ │░░░░░░░░░│'
        puts '│░░░░░░░░░│ │░░░░░░░░░│'
        puts '│░░░░░░░░░│ │░░░░░░░░░│'
        puts '│░░░░░░░░░│ │░░░░░░░░░│'
        puts '└─────────┘ └─────────┘'
    end
end 