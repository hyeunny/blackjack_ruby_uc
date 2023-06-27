class Card
    attr_reader :value, :suit

    VALID_VALUES = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']
    VALID_SUITS = ['SPADE', 'DIAMOND', 'HEART', 'CLUB']

    def initialize(value, suit)
        raise ArgumentError.new(
            "Argument (value) must be one of #{VALID_VALUES}."
        ) if !VALID_VALUES.include?(value)

        raise ArgumentError.new(
            "Argument (suit) must be one of #{VALID_SUITS}."
        ) if !VALID_SUITS.include?(suit)

        @value = value
        @suit = suit
    end

    def show
        card = <<-CARD
          ┌──────────┐ 
           #{value} 
          │          │ 
          │          │ 
               #{suit} 
          │          │ 
          │          │ 
                   #{value} 
          └──────────┘ 
        CARD

        puts card
    end

    def show_card_back
        card = <<-CARD
          ┌──────────┐ 
           ##########
          │          │ 
          │          │ 
           ##########
          │          │ 
          │          │ 
           ##########
          └──────────┘ 
        CARD

        puts card 
    end
end
