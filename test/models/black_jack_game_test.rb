require "test_helper"
require 'minitest/spec'

class BlackJackGameTest < ActiveSupport::TestCase
  describe 'calculating game state' do
    it 'computes player win states' do
      game = BlackJackGame.new
      player = game.player
      dealer = game.dealer

      # player has blackjack, dealer does not
      player.instance_variable_set(:@score, 21)
      dealer.instance_variable_set(:@score, 19)
      assert game.check_game_state() == BlackJackGame::PLAYER_WIN
      
      # dealer busts, player does not bust
      player.instance_variable_set(:@score, 17)
      dealer.instance_variable_set(:@score, 23)
      assert game.check_game_state() == BlackJackGame::PLAYER_WIN

      # player is closer to 21 at game end
      player.instance_variable_set(:@score, 19)
      dealer.instance_variable_set(:@score, 18)
      game.dealer_round_complete = true
      assert game.check_game_state() == BlackJackGame::PLAYER_WIN
    end

    it 'computes dealer win states' do
      game = BlackJackGame.new
      player = game.player
      dealer = game.dealer

      # dealer has blackjack, player does not
      player.instance_variable_set(:@score, 17)
      dealer.instance_variable_set(:@score, 21)
      assert game.check_game_state() == BlackJackGame::DEALER_WIN

      # player busts, dealer does not
      player.instance_variable_set(:@score, 24)
      dealer.instance_variable_set(:@score, 18)
      assert game.check_game_state() == BlackJackGame::DEALER_WIN

      # player and dealer both bust
      player.instance_variable_set(:@score, 23)
      dealer.instance_variable_set(:@score, 22)
      assert game.check_game_state() == BlackJackGame::DEALER_WIN

      # dealer is closer to 21 at game end
      player.instance_variable_set(:@score, 17)
      dealer.instance_variable_set(:@score, 18)
      game.dealer_round_complete = true
      assert game.check_game_state() == BlackJackGame::DEALER_WIN
    end

    it 'computes push (tied game) states' do
      game = BlackJackGame.new
      player = game.player
      dealer = game.dealer

      # player and dealer both get blackjack
      player.instance_variable_set(:@score, 21)
      dealer.instance_variable_set(:@score, 21)
      assert game.check_game_state() == BlackJackGame::PUSH

      # player and dealer both have the same score at game end
      player.instance_variable_set(:@score, 18)
      dealer.instance_variable_set(:@score, 18)
      game.dealer_round_complete = true
      assert game.check_game_state() == BlackJackGame::PUSH
    end

    it 'computes ongoing game state' do
      game = BlackJackGame.new
      player = game.player
      dealer = game.dealer

      # player can take another hit
      player.instance_variable_set(:@score, 12)
      dealer.instance_variable_set(:@score, 18)
      assert game.check_game_state() == BlackJackGame::ONGOING
    end
  end
end
