require_relative "board.rb"
require_relative "player.rb"

class Hand

    attr_accessor :cards_in_hand
    def initialize(board=nil) #ALWAYS PASS IN BOARD! nil is for debugging purposes
        @cards_in_hand = []
        @board = board
    end

    #just a player's two cards
    def small_hand #for players to see
        return @cards_in_hand
    end
    
    #a player's two cards combined with the flops
    def big_hand #for use
        return small_hand + @board.flop
    end

    def add_cards(first_card, second_card) #function for board to add 2 cards
        @cards_in_hand = [first_card, second_card]
    end

    def empty_hand!
        @cards_in_hand = []
    end

    # #best_five returns the best five of seven cards for a player
    # It returns an array containing: a score from 1-10, a tiebreaker score, and a tiebreaker-tiebreaker score (if needed)
    
    def best_five
        #b = big_hand

        #DELETE BELOW
        # b = small_hand + [Card.new(:seven, :hearts), Card.new(:queen, :hearts), Card.new(:nine, :hearts), Card.new(:king, :diamonds), Card.new(:eight, :clubs)]
        b = big_hand #WS: changed from @cards_in_hand to big hand
        ######
        
        raise StandardError.new("Total Hand Size is not 7") if b.length != 7

        b = b.sort_by{ |c| c.value}
        



        #VALUES:
        #Single = 1
        #Pair = 2
        #Double Pair = 3
        #Triple = 4
        #STRAIGHT = 5
        #FLUSH = 6
        #full house... does not need container is 7
        #FOUR OF A KIND -> auto returns -> 8
        #STRAIGHT_FLUSH -> 9
        #ROYAL_FLUSH -> 10

        best = nil
        best_score = 0

        straight_counter = 1

        duplicate_counter = 1

        suit_hash = Hash.new {|h,k| h[k] = []}
        suit_hash[b[0].suit] << 0 #INDICES!

        straight_holder = [b[0]] #bro i dont even know what the point of this is
        last_diff = b[0].value

        triples = []
        pairs = []

        #handle aces as 1s in straights...

        # debugger
        (1..6).each do |i|
            suit_hash[b[i].suit] << i
            this_is_bad_code = false
            #handle duplicates
            if (b[i-1].value == b[i].value)
                duplicate_counter += 1
            else
                this_is_bad_code = true
                case duplicate_counter   
                when 2
                    pairs << b[i-2..i-1]
                when 3 
                    triples << b[i-3..i-1]
                when 4
                    #Different in end case!!
                    best = b[i-4..i-1] #can't possibly have straight flush
                    best << b[-1]
                    best_score = 8

                    return [best, best_score, best[0].value]
                end

                duplicate_counter = 1
            end
            #handle straights
            if (last_diff + 1 == b[i].value)
                straight_counter += 1
                straight_holder << b[i]

                if straight_counter == 4 && b[i].value==5
                    if b[6].value == 14
                        if best_score < 5
                            best = [b[6]]
                            best = best.concat(straight_holder)
                            best_score = 5
                            #going to assume this dude isn't a straight flush...
                        end
                    end
                end
                                
                if straight_counter >= 5
                    if best_score <= 5
                        best_score = 5
                        best = straight_holder
                    end
                end
            elsif (last_diff + 1 < b[i].value)
                straight_holder = [b[i]] 
                straight_counter = 1
            end
            if this_is_bad_code == true
                last_diff = b[i].value
            end
        end

        if best_score == 5
            suit_hash.each do |v, k|
                if k.length >= 5
                    i = 1
                    count = 1
                    ans = [b[k[0]]]
                    while(i<k.length)
                        if b[k[i]].value == b[k[i-1]].value + 1
                            count += 1
                            ans << b[k[i]]
                        else
                            ans = [] if count < 5
                            count = 1
                        end
                        i += 1
                    end
                    if ans.length >= 5
                        if ans[-1].type == :ace
                            best_answer = 10
                            return [ans[-5..-1], 10, 1000]
                        else
                            best_answer = 9
                            return [ans[-5..-1], 9, ans[-1].value]
                        end
                    end
                else
                    break
                end
            end
        end

        case duplicate_counter
        when 2
            pairs << b[5..6]
        when 3 
            triples << b[4..6]
        when 4
            best = b[2..6] #can't possibly have straight flush
            best_score = 8
            return [best, best_score, b[6].value]
        end

        if !triples.empty? && !pairs.empty?
            best_score = 7
            best = pairs[-1] + triples[-1]
            return [best, best_score, best[-1].value]
        end

        suit_hash.each do |v, k|
            if k.length >= 5
                i = k.length - 5
                ans = []
                while(ans.length < 5)
                    ans << b[k[i]]
                    i += 1
                end
                best_score = 6
                return [ans, best_score, ans[-1].value * 15 + ans[-2].value, (ans[-3].value * 225) + (ans[-4].value * 15)+ ans[-5].value]
            end
        end

        if best_score == 5
            return [best[-5..-1], best_score, best[-1].value]
        end

        if triples.length > 0
            ans = triples[-1] 
            avoid = ans[0].value
            i = 6
            while i>=0
                if b[i].value != avoid
                    ans << b[i]
                    if ans.length == 5
                        best_score = 4
                        return [ans, best_score, avoid]
                    end
                end
                i -= 1
            end

            raise IndexError.new("Should never get here") 
        end

        if pairs.length > 1
            ans = pairs[-2].concat(pairs[-1])
            bad_x = ans[0].value
            bad_y = ans[3].value
            i = 6
            while i>=0
                if b[i].value != bad_x && b[i].value != bad_y
                    ans << b[i]
                    best_score = 3

                    if bad_x > bad_y 
                        bigger = bad_x 
                        smaller = bad_y
                    else
                        bigger = bad_y
                        smaller = bad_x
                    end

                    return [ans, best_score, bigger*15 + smaller, ans[-1].value]

                end
                i -= 1
            end

            raise IndexError.new("Should never get here") 
        end

        if pairs.length == 1
            ans = pairs[0]
            avoid = ans[0].value
            i = 6
            while i>=0
                if b[i].value != avoid
                    ans << b[i]
                    if ans.length == 5
                        best_score = 2
                        return [ans, best_score, avoid * 15 + ans[-3].value, ans[-2].value*15 + ans[-1].value]
                    end
                end
                i -= 1
            end
            raise IndexError.new("Should never get here") 
        end

        best_score = 1
        return [b[2..6], best_score, b[6].value*15 + b[5].value, b[2].value + (b[3].value * 15) + (b[4].value * 225)]
    end






end