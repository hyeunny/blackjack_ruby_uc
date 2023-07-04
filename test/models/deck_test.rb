require "test_helper"
require 'minitest/spec'

class DeckTest < ActiveSupport::TestCase
  describe '#new', 'initializing a deck' do
    it 'contains the correct number of cards' do
      deck = Deck.new
      assert deck.cards.length == 52
    end

    it 'has the expected cards by suit' do
      deck = Deck.new

      cards_per_suit = {}
      Card::VALID_SUITS.each do |suit|
        # 13 cards per suit
        per_suit = deck.cards.select{|card| card.suit == suit}
        assert per_suit.length == 13

        # expected values per suit
        assert per_suit.map {|card| card.value}.sort() == Card::VALID_VALUES.sort()
      end
    end
  end

  describe '#draw', 'drawing cards from a deck' do
    it 'draws the expected amount of cards from the deck' do
      deck = Deck.new
      deck.draw(2)
      assert deck.cards.length == 50
    end
  end

  describe '#shuffle_deck!', 'shuffling a deck' do
    it 'correctly shuffles the contents of the deck' do
      deck = Deck.new
      og_deck_serialized = deck.cards.map {|card| card.value+card.suit}.join(',')

      deck.send(:shuffle_deck!)
      after_shuffle_serialized = deck.cards.map {|card| card.value+card.suit}.join(',')

      assert og_deck_serialized != after_shuffle_serialized
    end
  end
end
