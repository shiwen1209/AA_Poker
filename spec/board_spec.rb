# describe Board do    
#     #describe "#initialize"
     
#     describe "#deal_players" do 
#         it "take in an array of players and should deal two cards to each player " do 
#             expect(deck.deal_players).to be_an_instance_of(Array)
#             expect(player1.hand).to include(Card)
#             expect(player1.hand.length).to eq(2)
#         end 
#     end

#     describe "#deal_flop" do 
#         it "should deal a card to the board -> flop" do 
#             expect(deck.deal_flop).to be_an_instance_of(Card)
#             expect(board.flop).to include(Card)
#         end 
#     end

# end