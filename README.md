# README

This repo contains a game of BlackJack implemented in ruby. The project was generated using rails to get free scaffolding for unit testing and easy debugging through rails console.

Effectively all the logic is implemented in the following files:

# Game Class (entry point)
app/models/black_jack_game.rb

# Classes used internally by game class
app/models/player.rb
app/models/deck.rb
app/models/card.rb

# Unit tests can found here
test/models/black_jack_game_test.rb
test/models/player_test.rb
test/models/deck_test.rb
test/models/card_test.rb

# The game can be run as follows:

open a rails console and run the following:

```
b = BlackJackGame.new()
b.play_game()
```

or launch directly with

```
rails rake play_blackjack
```