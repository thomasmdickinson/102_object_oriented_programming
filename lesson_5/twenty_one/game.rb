require_relative 'deck'
require_relative 'hand'
require_relative 'participant'

class TwentyOneGame
  attr_accessor :player, :dealer, :deck

  def initialize
    @player = Player.new
    @dealer = Dealer.new
  end

  def play
    set_up_game

    loop do
      set_up_round
      deal_cards
      announce_hands

      turn(player)

      unless player.busted?
        turn(dealer)
        reveal_hole unless dealer.busted?
      end

      display_announcements
      break unless play_again?
    end

    display_goodbye_message
  end

  def turn(participant)
    announce_hands
    loop do
      break unless participant.hit?
      deck.deal(1, participant)
      announce_hands
      if participant.busted?
        dealer.hand.has_hole = false
        announce_hands
        puts "#{participant.name} busted!"
        break
      end
    end
  end

  def set_up_game
    clear_screen
    display_welcome_message
    player.pick_name
    dealer.pick_name
  end

  def display_welcome_message
    puts "Welcome to Twenty-One!"
    puts ''
  end

  def display_goodbye_message
    clear_screen
    puts "Thanks for playing!"
  end

  def set_up_round
    @deck = Deck.new
    deck.shuffle
    player.clear_hand
    dealer.clear_hand
  end

  def deal_cards
    deck.deal(2, player)
    deck.deal(1, dealer)
    deck.deal(1, dealer, true)
  end

  def announce_hands
    clear_screen
    player.show_hand
    dealer.show_hand
  end

  def reveal_hole
    dealer.hand.has_hole = false
    puts "Now I'll reveal my full hand."
    sleep 2
    announce_hands
  end

  def winner
    if player.busted?
      dealer
    elsif dealer.busted?
      player
    else
      participant_with_highest_total
    end
  end

  def participant_with_highest_total
    if player.hand.total > dealer.hand.total
      player
    elsif dealer.hand.total > player.hand.total
      dealer
    end
  end

  def display_announcements
    announce_winner
    increment_winner_score
    announce_standings
  end

  def announce_winner
    sleep 1
    if !!winner
      puts "#{winner.name} wins!"
    else
      puts "It's a tie!"
    end
  end

  def increment_winner_score
    winner.score += 1 if !!winner
  end

  def champion
    if player.score >= 5
      player
    elsif dealer.score >= 5
      dealer
    end
  end

  def announce_standings
    sleep 1
    puts "#{player.name} has #{player.score} wins. #{dealer.name} has #{dealer.score} wins. First to 5 is the champion!"
    unless champion.nil?
      sleep 1
      puts "#{champion.name} is the champion! Huzzah!"
      clear_scores
    end
  end

  def clear_scores
    player.score = 0
    dealer.score = 0
  end

  def play_again?
    answer = nil
    loop do
      sleep 1
      puts "Play again? y/n"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Must pick y/n"
    end
    answer == 'y'
  end

  def clear_screen
    system 'clear'
  end
end

game = TwentyOneGame.new
game.play
