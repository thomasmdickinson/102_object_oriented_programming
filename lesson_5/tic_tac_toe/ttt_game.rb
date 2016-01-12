require_relative 'ttt_board'
require_relative 'ttt_players'

class TTTGame
  VALID_MARKERS = %w(x o)
  FIRST_TO_MOVE = 'x'

  attr_accessor :difficulty
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new
    @computer = Player.new
    @current_marker = FIRST_TO_MOVE
  end

  def play
    setup_game

    loop do
      setup_round

      loop do
        current_player_moves
        break if board.someone_won? || board.full?
        clear_screen_and_display_board
      end

      display_result
      champ_check
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
    set_difficulty
  end

  def setup_round
    pick_markers
    clear_screen_and_display_board
  end

  def pick_names
    human.name = pick_player_name
    computer.name = pick_computer_name
  end

  def set_difficulty
    puts "Enter 1 for easy, 2 for hard."
    diff = nil
    loop do
      diff = gets.chomp.to_i
      break if (1..2).include?(diff)
      puts "That's not a valid difficulty!"
    end
    @difficulty = diff
  end

  def pick_player_name
    puts "What's your name?"
    name = ''
    loop do
      name = gets.chomp
      break if !name.empty?
      puts "Come on, just tell me your name."
    end
    name
  end

  def pick_computer_name_name
    %w('GLaDOS', 'BB-8', 'K-9', 'Marvin', 'HAL', 'WALL-E', 'Watson').sample
  end

  def pick_markers
    human.marker = pick_player_marker
    computer.marker = pick_computer_marker
  end

  def pick_player_marker
    puts "Would you like to be X or O? X goes first!"
    choice = ''
    loop do
      choice = gets.chomp.downcase
      break if VALID_MARKERS.include?(choice)
      puts "That's not a valid choice!"
    end
    choice
  end

  def pick_computer_marker
    return 'x' if human.marker == 'o'
    'o'
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
    puts "|||||||||||||||||||||||||"
    puts "||" + "#{human.name} is x".upcase.center(21) + "||"
    puts "||" + "#{computer.name} is o".upcase.center(21) + "||"

    board.draw
    sleep 1
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def current_player_moves
    if @current_marker == human.marker
      human_moves
      @current_marker = computer.marker
    else
      computer_moves
      @current_marker = human.marker
    end
  end

  def human_inputs_move
    puts "Choose a square: #{board.unmarked_keys.join(', ')}."
    square = ''
    loop do
      square = gets.chomp
      if board.unmarked_keys.include?(square.to_i) || %w(r c).include?(square.downcase)
        break
      else
        puts "Sorry, try again."
      end
    end
    square
  end

  def human_moves
    square = human_inputs_move
    if square == 'r'          # cheat code 1 - random play
      board[pick_random_empty_square] = human.marker
    elsif square == 'c'       # cheat code 2 - AI plays for you
      board[pick_square_with_smarts(human, computer)] = human.marker
    else
      board[square.to_i] = human.marker
    end
  end

  def computer_moves
    square = nil
    if difficulty == 1
      square = pick_random_empty_square
    else
      square = pick_square_with_smarts(computer, human)
    end
    board[square] = computer.marker
  end

  def pick_random_empty_square
    board.unmarked_keys.to_a.sample
  end

  def pick_random_empty_corner
    board.unmarked_corner_keys.to_a.sample
  end

  def pick_line_completer(player, opponent)
    if !!board.completing_marker(player.marker)
      board.completing_marker(player.marker)
    end
    board.completing_marker(opponent.marker)
  end

  def pick_fork_point(player, opponent)
    if !!board.fork_marker(player.marker)
      return board.fork_marker(player.marker)
    end
    board.fork_marker(opponent.marker)
  end

  def pick_square_with_smarts(player, opponent)
    if board.empty?
      pick_random_empty_corner
    elsif board.winning_move_possible?
      pick_line_completer(player, opponent)
    elsif board.fork_possible?
      pick_fork_point(player, opponent)
    elsif board.center_open?
      5
    elsif any_corners_open?
      pick_random_empty_corner
    else
      pick_random_empty_square
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
    return false if answer == 'n'
    true
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

  def champ_check
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
