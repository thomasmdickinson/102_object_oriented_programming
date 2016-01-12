require 'pry'
require_relative 'board'
require_relative 'player'

class TTTGame
  VALID_MARKERS = %w(x o)
  FIRST_TO_MOVE = 'x'

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Computer.new
    @current_marker = FIRST_TO_MOVE
  end

  def play
    setup_game

    loop do
      setup_round

      loop do
        current_player_moves
        break if board.someone_won? || board.full?
        alternate_between_players
        clear_screen_and_display_board
      end

      display_result
      check_for_champion
      break unless play_again?
      reset
      display_again_message
    end

    display_goodbye_message
  end

  private

  def setup_game
    clear
    display_welcome_message
    pick_names
    set_computer_difficulty
  end

  def setup_round
    pick_markers
    clear_screen_and_display_board
  end

  def pick_names
    human.pick_name
    computer.pick_name
  end

  def set_computer_difficulty
    puts "Enter 1 for easy, 2 for hard."
    diff = nil
    loop do
      diff = gets.chomp.to_i
      break if (1..2).include?(diff)
      puts "That's not a valid difficulty!"
    end
    computer.difficulty = diff
  end

  def pick_markers
    human.pick_marker
    computer.pick_marker(human)
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ''
    sleep 1
  end

  def display_goodbye_message
    puts "Goodbye!"
  end

  def clear
    system 'clear'
  end

  def display_board
    draw_header
    board.draw
    sleep 1
  end

  def draw_header
    puts "|||||||||||||||||||||||||"
    puts "||" + "#{human.name} is x".upcase.center(21) + "||"
    puts "||" + "#{computer.name} is o".upcase.center(21) + "||"
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def current_player_moves
    if @current_marker == human.marker
      human.move(board, computer)
    else
      computer.move(board, human)
    end
  end

  def alternate_between_players
    if @current_marker == human.marker
      @current_marker = computer.marker
    else
      @current_marker = human.marker
    end
  end

  def winning_player
    case board.winning_marker
    when human.marker then human
    when computer.marker then human
    end
  end

  def display_result
    clear_screen_and_display_board
    if !!winning_player
      puts "#{winning_player.name} won!"
      winning_player.score += 1
    else
      puts "It's a tie!"
    end

    puts "Current standings: Human #{human.score}, Computer #{computer.score}"
  end

  def play_again?
    answer = nil
    loop do
      puts "Play again? y/n"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Must pick y/n"
    end
    answer == 'y'
  end

  def reset
    board.reset
    @current_marker = human.marker
    clear
  end

  def display_again_message
    puts "Let's play again!"
    puts ''
  end

  def check_for_champion
    [human, computer].each { |champ| declare_champ(champ) if champ.score >= 5 }
  end

  def declare_champ(winner)
    puts "#{winner.name} is the champ!"
    clear_scores
  end

  def clear_scores
    human.score = 0
    computer.score = 0
  end
end

game = TTTGame.new
game.play
