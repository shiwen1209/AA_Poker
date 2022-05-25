require_relative "card.rb"

class Deck 
    attr_accessor :dealer_deck

    def initialize
        @dealer_deck = []
        populate
    end

    def populate
        @dealer_deck = []
        Card.all_suits.each do |s|
            Card.all_types.each do |t|
                @dealer_deck << Card.new(t, s)
            end
        end
        return nil
    end

    def shuffle!
        @dealer_deck.shuffle!
    end

    def empty?
        @dealer_deck.empty?
    end

    def deal(num)
        @dealer_deck.sample((num*2)+5)
    end

end