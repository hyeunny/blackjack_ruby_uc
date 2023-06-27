class BlackJackGame
    attr_reader :dealer, :player
    attr_accessor :dealer_round_complete

    PUSH = 'push'
    PLAYER_WIN = 'player_win'
    DEALER_WIN = 'dealer_win'
    ONGOING = 'ongoing'

    def initialize
        @deck = Deck.new
        @dealer = Player.new(Player::DEALER, @deck)
        @player = Player.new(Player::PLAYER, @deck)
        @dealer_round_complete = false
    end

    def play_game
        player.deal()
        player.show()

        dealer.deal()
        dealer.show()

        game_state = check_game_state()
        while game_state == ONGOING
            p 'Hit or Pass?'
            cmd = STDIN.gets.chomp.downcase
            p '=================================================='

            if cmd == 'hit'
                player.draw()
                player.show()
            elsif cmd == 'pass'
                # dealer flipping face down card face up must be registered as a move
                sleep(1)
                dealer.increment_move()
                dealer.show()
                while dealer.score < 17
                    dealer.draw()
                    dealer.show()
                    sleep(1)
                end
                self.dealer_round_complete = true
            else
                p 'Command is invalid please try again. Options are hit or pass.'
                next
            end
            
            # reveal dealer face down card if player hits blackjack
            dealer.increment_move() if player.score == 21 && dealer.moves == 1

            game_state = check_game_state()
        end

        p '=================================================='
        p "game state: #{game_state}"
        p "here are the final hands and scores: "
        p '=================================================='
        sleep(2)
        player.show()
        dealer.show()
    end

    def check_game_state
        # push: player & dealer blackjack
        return PUSH if player.score == 21 && dealer.score == 21

        # dealer win: player bust
        return DEALER_WIN if player.score > 21

        # dealer win: dealer blackjack
        return DEALER_WIN if dealer.score == 21

        # player win: player blackjack 
        return PLAYER_WIN if player.score == 21

        # player win: dealer bust
        return PLAYER_WIN if dealer.score > 21

        if dealer_round_complete
            player_diff = 21 - player.score
            dealer_diff = 21 - dealer.score

            # push: same score
            return PUSH if player_diff == dealer_diff
            # player win: player closer to 21
            return PLAYER_WIN if player_diff < dealer_diff
            # dealer win: dealer closer to 21
            return DEALER_WIN if player_diff > dealer_diff
        end

        # continue the game
        ONGOING
    end
end
