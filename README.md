# README

This repo contains a game of BlackJack implemented in ruby. The project was generated using rails to get free scaffolding for unit testing and easy debugging through rails console.

Effectively all the logic is implemented in the following files:

# Game Class (entry point)
```
app/models/black_jack_game.rb
```

# Classes used internally by game class
```
app/models/player.rb
app/models/deck.rb
app/models/card.rb
```

# Unit tests can found here
```
test/models/black_jack_game_test.rb
test/models/player_test.rb
test/models/deck_test.rb
test/models/card_test.rb
```

# The game can be run as follows:

open a rails console and run the following:

```
b = BlackJackGame.new()
b.play_game()
```

or launch directly with

```
rake play_blackjack
```

# The game is made to run in the CLI
<img width="1023" alt="image" src="https://github.com/hyeunny/blackjack_ruby_uc/assets/7348950/737fc54c-716a-4ff0-b5c6-18c1aabc950f">
