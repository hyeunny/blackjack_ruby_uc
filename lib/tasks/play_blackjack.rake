task :play_blackjack => :environment do
    b = ::BlackJackGame.new()
    b.play_game()
end
