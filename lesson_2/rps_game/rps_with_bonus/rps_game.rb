require 'pry'

require_relative 'rps_players'
require_relative 'rps_moves'

# To-do
# Adjust computer choice based on history
# Computer personalities

# Game orchestration engine
class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = [
      Randy.new,
      Cheater.new,
      Picky.new,
      Mimic.new
    ].sample
    @computer.announce_name
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
    puts "First to 10 points is the champion!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper Scissors, Lizard, Spock. Bye Bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      human.win
    elsif human.move < computer.move
      human.win
    else
      puts "It's a tie!"
    end
  end

  def clear_score
    human.score = 0
    computer.score = 0
  end

  def announce_standings
    [human, computer].each do |player|
      puts "#{player.name} has #{player.score} points."
      if player.score >= 10
        puts "#{player.name} is the champion!"
        clear_score
      end
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? y/n"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n."
    end
    answer.downcase == 'y'
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose(human)
      display_moves
      display_winner
      announce_standings
      break unless play_again?
    end
    display_goodbye_message
  end
end

my_game = RPSGame.new
my_game.play
