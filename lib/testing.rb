#THIS FILE IS FOR TESTING PURPOSES ONLY




# require_relative "card.rb"
# require_relative "hand.rb"
# require_relative "deck.rb"
# require "byebug"

# d = Deck.new
# h = Hand.new

# h.cards_in_hand = d.dealer_deck.sample(7)

# #h.cards_in_hand = [Card.new(:two, :spades), Card.new(:nine, :diamonds), Card.new(:seven, :hearts), Card.new(:queen, :hearts), Card.new(:nine, :hearts), Card.new(:king, :diamonds), Card.new(:eight, :clubs)]
# #h.cards_in_hand = [Card.new(:six, :clubs), Card.new(:ace, :spades), Card.new(:eight, :diamonds), Card.new(:six, :diamonds), Card.new(:three, :clubs), Card.new(:nine, :clubs), Card.new(:three, :spades)]
# #h.cards_in_hand = [Card.new(:eight, :clubs), Card.new(:three, :clubs), Card.new(:nine, :hearts), Card.new(:three, :hearts), Card.new(:eight, :diamonds), Card.new(:queen, :diamonds), Card.new(:queen, :spades)]

# #testing straights
# #h.cards_in_hand = [Card.new(:ten, :clubs), Card.new(:nine, :spades), Card.new(:ten, :hearts), Card.new(:jack, :clubs), Card.new(:eight, :diamonds), Card.new(:queen, :diamonds), Card.new(:ten, :spades)]
# # h.cards_in_hand = [Card.new(:three, :clubs), Card.new(:two, :spades), Card.new(:ace, :hearts), Card.new(:five, :diamonds), Card.new(:ace, :diamonds), Card.new(:four, :hearts), Card.new(:two, :spades)]

# #testing flush
# # h.cards_in_hand = [Card.new(:three, :spades), Card.new(:two, :spades), Card.new(:ace, :hearts), Card.new(:five, :diamonds), Card.new(:ten, :spades), Card.new(:four, :spades), Card.new(:two, :spades)]

# #testing full house
# # h.cards_in_hand = [Card.new(:three, :spades), Card.new(:three, :hearts), Card.new(:three, :clubs), Card.new(:five, :diamonds), Card.new(:ten, :spades), Card.new(:ten, :diamonds), Card.new(:ace, :hearts)]

# #testing four
# # h.cards_in_hand = [Card.new(:three, :spades), Card.new(:three, :hearts), Card.new(:three, :clubs), Card.new(:three, :diamonds), Card.new(:ten, :spades), Card.new(:ten, :diamonds), Card.new(:ten, :hearts)]
# # h.cards_in_hand = [Card.new(:queen, :spades), Card.new(:queen, :hearts), Card.new(:queen, :clubs), Card.new(:queen, :diamonds), Card.new(:ten, :spades), Card.new(:six, :diamonds), Card.new(:two, :clubs)]

# #testing straight flush 
# # h.cards_in_hand = [Card.new(:ten, :diamonds), Card.new(:nine, :diamonds), Card.new(:ace, :diamonds), Card.new(:jack, :diamonds), Card.new(:eight, :diamonds), Card.new(:queen, :diamonds), Card.new(:king, :diamonds)]


# f = Array.new(9, "") #VERY POOR NAMING, not same as above
# h.cards_in_hand.each do |card|
#     f[0] += "┌─────────┐ "
#     f[1] += "│#{card.type_s.ljust(2)}       │ "  # use two {} one for char, one for space or char
#     f[2] += "│         │ "
#     f[3] += "│         │ "
#     f[4] += "│    #{card.suit_s}    │ "
#     f[5] += "│         │ "
#     f[6] += "│         │ "
#     f[7] += "│       #{card.type_s.rjust(2)}│ "
#     f[8] += "└─────────┘ "
# end
    
# (0..8).each do |line|
#     puts f[line]
# end

# five = Array.new(9, "")

# best_five, ranking, score = h.best_five

# best_five.each do |card|
#     five[0] += "┌─────────┐ "
#     five[1] += "│#{card.type_s.ljust(2)}       │ "  # use two {} one for char, one for space or char
#     five[2] += "│         │ "
#     five[3] += "│         │ "
#     five[4] += "│    #{card.suit_s}    │ "
#     five[5] += "│         │ "
#     five[6] += "│         │ "
#     five[7] += "│       #{card.type_s.rjust(2)}│ "
#     five[8] += "└─────────┘ "
# end

# p "Best Five Cards with a ranking of #{ranking} and tiebreaker score of #{score}"

# (0..8).each do |line|
#     puts five[line]
# end

# # end

# (0..100).each do |i|
#     p i
#     sleep(0.01)
#     print "\33c\e[3J"
# end

# (0..20).each do |i|
#     p i
#     sleep(0.05)
#     print "\33c\e[3J"
# end
###
# require 'bcrypt'

# puts "please enter a password"
# inp = gets.chomp
# a = BCrypt::Password.create(inp)
# puts a
# puts ""

# puts "please enter your password"
# password = gets.chomp
# puts BCrypt::Password.new(a).is_password?(password)
###

testme = "abc"
puts "\e[3m#{testme}\e[23m"