class Player
  attr_accessor :name, :marker, :score
  attr_reader

  def initialize
    @score = 0
  end

  def pick_random_empty_square(board)
    board.unmarked_keys.to_a.sample
  end

  def pick_square_with_smarts(board, player, opponent)
    if board.empty?
      pick_random_empty_corner(board)
    elsif board.winning_move_possible?
      pick_line_completer(board, player, opponent)
    elsif board.fork_possible?
      pick_fork_point(board, player, opponent)
    elsif board.center_open?
      5
    elsif board.any_corners_open?
      pick_random_empty_corner(board)
    else
      pick_random_empty_square(board)
    end
  end

  def pick_random_empty_corner(board)
    board.unmarked_corner_keys.to_a.sample
  end

  def pick_line_completer(board, player, opponent)
    if !!board.completing_marker(player.marker)
      board.completing_marker(player.marker)
    end
    board.completing_marker(opponent.marker)
  end

  def pick_fork_point(board, player, opponent)
    if !!board.fork_marker(player.marker)
      return board.fork_marker(player.marker)
    end
    board.fork_marker(opponent.marker)
  end

end
