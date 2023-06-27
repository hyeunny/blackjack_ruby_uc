class Player
    attr_reader :player_type, :deck
    attr_accessor :hand, :score, :moves

    PLAYER = 'player'
    DEALER = 'dealer'
    PLAYER_TYPES = [PLAYER, DEALER]

    SCORE_MAP = {
        '2' => 2,
        '3' => 3,
        '4' => 4,
        '5' => 5,
        '6' => 6,
        '7' => 7,
        '8' => 8,
        '9' => 9,
        '10' => 10,
        'J' => 10,
        'Q' => 10,
        'K' => 10,
        'A' => 11
    }

    def initialize(player_type, deck)
        raise ArgumentError.new(
            "Argument (player_type) must be one of #{PLAYER_TYPES}."
        ) if !PLAYER_TYPES.include?(player_type)

        raise ArgumentError.new(
            "Argument (deck) must be of type #{deck.class}}."
        ) if deck.class != Deck

        @player_type = player_type
        @hand = []
        @deck = deck
        @score = 0
        @moves = 0
    end

    def deal
        self.hand += (deck.draw(2))
        self.increment_move
    end

    def draw
        self.hand += (deck.draw(1))
        self.increment_move
    end

    def show
        p "#{player_type} hand is: "

        hand.each_with_index do |card, card_idx|
            if dealer_first_move() && card_idx == 1
                card.show_card_back()
            else
                card.show()
            end
        end

        p "#{player_type} score is: #{score}"
    end

    def increment_move
        self.moves += 1
        self.check_score
    end

    private

    def dealer_first_move
        moves == 1 && player_type == DEALER
    end

    def check_score
        ace_counter = 0
        calc_score = 0

        hand.each_with_index do |card, card_idx|
            next if dealer_first_move() && card_idx == 1
            card_score = SCORE_MAP[card.value]
            calc_score += card_score
            ace_counter += 1 if card_score == 11
        end

        # ensure aces going over 21 are worth 1
        while ace_counter > 0 && calc_score > 21
            calc_score -= 10
            ace_counter -= 1
        end

        self.score = calc_score
    end
end
