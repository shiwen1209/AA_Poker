require "card"

describe Card do
    subject(:c) {Card.new(:jack, :hearts)}
    describe "#initialize" do
        
        it "should take in two parameters" do
            expect {Card.new(:king, :spades)}.to_not raise_error
        end

        it "should set them two their respective accessible parameters" do
            expect{c.type}.to_not raise_error
            expect(c.type).to be_truthy
            expect{c.suit}.to_not raise_error
            expect(c.suit).to be_truthy
        end
    end

    describe "#value" do
        it "should return the correct value" do
            expect {c.value}.to_not raise_error
            expect(c.value).to eq(11)
        end
    end

    # describe "#type_s"

    describe "#suit_s" do
        it "should return the string representation of the suit" do
            expect {c.value}.to_not raise_error
        end
    end

    #describe "#card_picture"


end