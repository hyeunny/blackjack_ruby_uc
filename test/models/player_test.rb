require "test_helper"
require 'minitest/spec'

class PlayerTest < ActiveSupport::TestCase
  describe '#new', 'initializing a player' do
    it 'raises an argument error with invalid player_type arg' do
      assert_raises(ArgumentError) do
        Player.new('baz', Deck.new)
      end
    end

    it 'raises an argument error when deck arg is not the expected class' do
      assert_raises(ArgumentError) do
        Player.new(Player::DEALER, [])
      end
    end

    describe '#deal', 'dealing cards' do
      it 'updates the deck and player move and score states' do
        deck = Deck.new
        player = Player.new(Player::PLAYER, deck)

        # deal draws 2
        player.deal()
        assert deck.cards.length == 50
        assert player.moves == 1

        assert player.score > 0
      end
    end

    describe '#draw', 'drawing cards' do
      it 'updates the deck and player move and score states' do
        deck = Deck.new
        player = Player.new(Player::PLAYER, deck)
        
        # draw draws 1
        player.draw()
        assert deck.cards.length == 51
        assert player.moves == 1

        assert player.score > 0
      end
    end

    describe '#check_score', 'calculating player score' do
      it 'calculates the score correctly' do
        deck = Deck.new
        player = Player.new(Player::PLAYER, deck)

        # with non ace cards
        player.instance_variable_set(:@hand, [
          Card.new('J', 'SPADE'),
          Card.new('8', 'SPADE')
        ])

        player.send(:check_score)
        assert player.score == 18

        # with ace cards exceeding 21
        player.instance_variable_set(:@hand, [
          Card.new('Q', 'HEART'),
          Card.new('4', 'CLUB'),
          Card.new('A', 'DIAMOND')
        ])

        player.send(:check_score)
        assert player.score == 15
      end

      describe 'when player is dealer' do
        it 'skips calculating the score for the face down card on the first move' do
          deck = Deck.new
          player = Player.new(Player::DEALER, deck)

          player.deal()
          assert player.score == Player::SCORE_MAP[player.hand[0].value]
        end
      end
    end
  end
end
