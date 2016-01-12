class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                   [1, 4, 7], [2, 5, 8], [3, 6, 9],
                   [1, 5, 9], [3, 5, 7]]
  def initialize
    @squares = {}
    reset
  end

  def draw
    puts "|||||||||||||||||||||||||"
    puts "||                     ||"
    puts "||    +---+---+---+    ||"
    puts "||    | #{@squares[1]} | #{@squares[2]} | #{@squares[3]} |    ||"
    puts "||    |---+---+---|    ||"
    puts "||    | #{@squares[4]} | #{@squares[5]} | #{@squares[6]} |    ||"
    puts "||    |---+---+---|    ||"
    puts "||    | #{@squares[7]} | #{@squares[8]} | #{@squares[9]} |    ||"
    puts "||    +---+---+---+    ||"
    puts "||                     ||"
    puts "|||||||||||||||||||||||||"
    puts ''
  end

  def [](key)
    @squares[key]
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def unmarked_corner_keys
    unmarked_keys.select { |key| [1, 3, 7, 9].include?(key) }
  end

  def any_corners_open?
    !board.unmarked_corner_keys.empty?
  end

  def center_open?
    unmarked_keys.include?(5)
  end

  def full?
    unmarked_keys.empty?
  end

  def empty?
    unmarked_keys.size == 9
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      return squares.first.marker if three_identical_markers?(squares)
    end
    nil
  end

  def completing_marker(marker)
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if line_almost_complete?(squares) &&
         squares.reject { |i| i == ' ' }.first.marker == marker
        completing_square = squares.find { |sq| sq.marker == ' ' }
        return @squares.index(completing_square)
      end
    end
    nil
  end

  def fork_possible?
    TTTGame::VALID_MARKERS.each { |marker| return true if fork_marker(marker) }
    false
  end

  def fork_marker(marker)
    @squares.keys.each do |key|
      hypothetical = what_if(key, marker)
      possible_wins_from_square = 0
      WINNING_LINES.each do |line|
        squares = hypothetical.values_at(*line)
        possible_wins_from_square += 0 if line_almost_complete?(squares)
      end
      return key if possible_wins_from_square > 1
    end
    nil
  end

  def winning_move_possible?
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      return true if line_almost_complete?(squares)
    end
    false
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  private

  def what_if(key, marker)
    hypothetical = {}
    (1..9).each { |num| hypothetical[num] = @squares[num].clone }
    hypothetical[key].marker = marker
    hypothetical
  end

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.uniq.size == 1
  end

  def line_almost_complete?(squares)
    unique_markers = squares.collect(&:marker).uniq
    compact_markers = squares.collect(&:marker).reject { |i| i == ' ' }
    return true if unique_markers.size == 2 && compact_markers.size == 2
    false
  end
end

class Square
  INITIAL_MARKER = ' '
  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end
