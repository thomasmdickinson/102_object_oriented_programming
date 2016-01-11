require 'pry'
require_relative 'ttt_board'

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  HUMAN_MARKER = 'x'
  COMPUTER_MARKER = 'o'

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ''
  end

  def display_goodbye_message
    puts "Goodbye!"
  end

  def display_board(clear = true)
    system 'clear' if clear
    puts "You're a #{HUMAN_MARKER}. Computer is #{COMPUTER_MARKER}."
    puts ''
    puts "+---+---+---+"
    puts "| #{board.get_square_at(1)} | #{board.get_square_at(2)} | #{board.get_square_at(3)} |"
    puts "|---+---+---|"
    puts "| #{board.get_square_at(4)} | #{board.get_square_at(5)} | #{board.get_square_at(6)} |"
    puts "|---+---+---|"
    puts "| #{board.get_square_at(7)} | #{board.get_square_at(8)} | #{board.get_square_at(9)} |"
    puts "+---+---+---+"
    puts ''
  end

  def human_moves
    puts "Choose a square: #{board.unmarked_keys.join(', ')}."
    square = ''
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, try again."
    end
    board.set_square_at(square, human.marker)
  end

  def computer_moves
    board.set_square_at(board.unmarked_keys.to_a.sample, computer.marker)
  end

  def display_result
    display_board
    case board.detect_winner
      when HUMAN_MARKER then puts "You won!"
      when COMPUTER_MARKER then puts "Computer won!"
      else puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Play again? y/n"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Must pick y/n"
    end
    return false if answer == 'n'
    true
  end

  def play
    display_welcome_message
    system 'clear'

    loop do
      display_board(false)

      loop do
        human_moves
        break if board.someone_won? || board.full?
        display_board

        computer_moves
        break if board.someone_won? || board.full?
        display_board
      end

      display_result

      break unless play_again?
      board.reset
      system 'clear'
      puts "Let's play again!"
    end

    display_goodbye_message
  end
end

game = TTTGame.new
game.play
