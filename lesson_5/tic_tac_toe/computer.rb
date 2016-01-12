class Computer < Player
  attr_accessor :difficulty
  POSSIBLE_NAMES = %w(GLaDOS BB-8 K-9 Marvin HAL WALL-E Watson)

  def pick_name
    @name = POSSIBLE_NAMES.sample
  end

  def pick_marker(opponent)
    if opponent.marker == 'o'
      @marker = 'x'
    else
      @marker = 'o'
    end
  end

  def move(board, opponent)
    square = if @difficulty == 1

               square = pick_random_empty_square(board)
             else
               square = pick_square_with_smarts(board, self, opponent)
             end
    board[square] = @marker
  end
end
