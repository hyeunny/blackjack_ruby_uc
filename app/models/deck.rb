class Deck
    attr_accessor :cards

    def initialize
        @cards = self.generate_deck
        self.shuffle_deck!
    end

    def draw(count)
        drawn_cards = []

        count.times do
            card = cards.pop()
            drawn_cards.push(card)
        end

        drawn_cards
    end

    private

    def shuffle_deck!
        cards.shuffle!
    end

    def generate_deck
        new_deck = []

        ::Card::VALID_VALUES.each do |value|
            ::Card::VALID_SUITS.each do |suit|
                card = Card.new(value, suit)
                new_deck.push(card)
            end
        end

        new_deck
    end
end
