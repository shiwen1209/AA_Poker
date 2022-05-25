require "deck"
require "card"

describe Deck do 
    
    let(:deck) {Deck.new}

    describe "#initialize" do
        it "should initialize an empty deck for the dealer" do
            expect(deck.used_deck).to eq([])
        end
    end

    describe "#populate" do
        it "it should populate the deck with 52 different cards" do
            expect(deck.populate).to eq(nil)
            expect(deck.dealer_deck.length).to eq(52)
            expect(deck.dealer_deck[0]).to be_an_instance_of(Card)
            expect(deck.dealer_deck[10]).to be_an_instance_of(Card)
        end
    end

    let(:deck1) do
        deck = Deck.new
        deck.dealer_deck = []
        deck
    end



    let(:deck2) do
        deck = Deck.new
        deck.dealer_deck = [Card.new(:jack, :hearts), Card.new(:seven, :clubs)]
        deck

    end

    describe "#deal" do
        it "should deal a card and return the card" do 
            expect(deck2.deal).to be_an_instance_of(Array)
        end 
        
    end

    # describe "#empty?" do
    #     it "should check if the dealer_deck is empty" do 
    #         expect(deck1.empty?).to eq(true)
    #         expect(deck2.empty?).to eq(false)
    #     end
    # end

    # describe "#shuffle!" do
    #     it "should not change the cards in the deck" do 
    #         expect(deck2.dealer_deck.length).to eq(2)
    #     end
    # end

    # let(:deck4) do
    #     d = Deck.new
    #     d.dealer_deck = []
    #     d.used_deck = [Card.new(:jack, :hearts), Card.new(:seven, :clubs)]
    #     d
    # end

    # describe "#reload" do
    #     it "it should reload cards when cards become empty" do 
    #         expect(deck4.reload).to eq(true)
    #         expect(deck2.reload).to eq(false)
    #     end

    #     it "it should reload the used deck and the used deck become empty" do 
    #         deck4.reload
    #         expect(deck4.dealer_deck.length).to eq(2)
    #         expect(deck4.used_deck.length).to eq(0)
    #     end
    # end
end   