class Human <Player
  def pick_name
    puts "What's your name?"
    name = ''
    loop do
      name = gets.chomp
      break unless name.empty?
      puts "Come on, just tell me your name."
    end
    @name = name
  end

  def pick_marker
    puts "Would you like to be X or O? X goes first!"
    choice = ''
    loop do
      choice = gets.chomp.downcase
      break if TTTGame::VALID_MARKERS.include?(choice)
      puts "That's not a valid choice!"
    end
    @marker = choice
  end

  def move(board, opponent)
    desired_move = enter_move(board)
    if desired_move == 'r'          # cheat code 1 - random play
      board[pick_random_empty_square(board)] = @marker
    elsif desired_move == 'c'       # cheat code 2 - AI plays for you
      board[pick_square_with_smarts(board, self, opponent)] = @marker
    else
      board[desired_move.to_i] = @marker
    end
  end

  def enter_move(board)
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
end
