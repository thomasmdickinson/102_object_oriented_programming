class Move
  attr_reader :win, :value

  VALUES = %w(rock paper scissors lizard spock)

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def spock?
    @value == 'spock'
  end

  def lizard?
    @value == 'lizard'
  end

  def win_game
    @win = true
  end

  def win_probability(player, choice)
    times_used = player.history.select { |move| move.value == choice }
    times_won = times_used.select(move.win)
    times_won.size.to_f / times_used.size.to_f
  end

  def to_s
    @value
  end
end

# I think adding subclasses for each move was probably not the best
# design decision. It has the benefit of making the method definitions
# for > and < a little easier to scan, but it adds complexity and length
# to the choose methods in both the Human and Computer classes.

class Rock < Move
  def initialize
    @value = 'rock'
    @win = false
  end

  def >(other_move)
    other_move.scissors? || other_move.lizard?
  end

  def <(other_move)
    other_move.paper? || other_move.spock?
  end
end

class Paper < Move
  def initialize
    @value = 'paper'
    @win = false
  end

  def >(other_move)
    other_move.rock? || other_move.spock?
  end

  def <(other_move)
    other_move.paper? || other_move.lizard?
  end
end

class Scissors < Move
  def initialize
    @value = 'scissors'
    @win = false
  end

  def >(other_move)
    other_move.paper? || other_move.lizard?
  end

  def <(other_move)
    other_move.rock? || other_move.spock?
  end
end

class Lizard < Move
  def initialize
    @value = 'lizard'
    @win = false
  end

  def >(other_move)
    other_move.paper? || other_move.spock?
  end

  def <(other_move)
    other_move.rock? || other_move.scissors?
  end
end

class Spock < Move
  def initialize
    @value = 'spock'
    @win = false
  end

  def >(other_move)
    other_move.scissors? || other_move.rock?
  end

  def <(other_move)
    other_move.paper? || other_move.lizard?
  end
end
