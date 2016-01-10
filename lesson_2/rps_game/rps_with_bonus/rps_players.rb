class Player
  attr_accessor :move, :name, :score, :history

  def initialize
    set_name
    @score = 0
    @history = []
  end

  def display_history
    puts "Move history for #{@name}:"
    @history.each { |move| puts ":: #{move} #{'(win)' if move.win}" }
  end

  def win
    puts "#{@name} won!"
    @move.win_game
    @score += 1
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Don't be shy, tell me a name."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, or spock:"
      choice = gets.chomp.downcase
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    self.move = translate(choice)
    @history << @move
  end

  def translate(choice)
    case choice
    when 'rock'     then Rock.new
    when 'paper'    then Paper.new
    when 'scissors' then Scissors.new
    when 'lizard'   then Lizard.new
    when 'spock'    then Spock.new
    end
  end
end

class Computer < Player
  def announce_name
    puts "You're playing against #{@name}."
  end
end

class Cheater < Computer
  def set_name
    self.name = "Cheater"
  end

  def choose(opponent)
    options = [Rock.new, Paper.new, Scissors.new, Lizard.new, Spock.new].select { |choice| choice > opponent.move }
    self.move = options.sample
    @history << @move
  end
end

class Mimic < Computer
  def set_name
    self.name = "Mimic"
  end

  def choose(opponent)
    if opponent.history.size < 2
      self.move = [Rock.new, Paper.new, Scissors.new, Lizard.new, Spock.new].sample
    else
      self.move = opponent.history[-2].clone
    end
    @history << @move
  end
end

class Randy < Computer
  def set_name
    self.name = "Randy"
  end

  def choose(_)
    self.move = [Rock.new, Paper.new, Scissors.new, Lizard.new, Spock.new].sample
    @history << @move
  end
end

class Picky < Computer
  def set_name
    self.name = "Cheater"
  end

  def choose(_)
    options = [Rock.new, Paper.new, Scissors.new, Lizard.new, Spock.new]
    choice = options.sample
    if choice.win_probability(self, choice.to_s) < 0.4
      if rand(10) > 4
        options.sample
      end
    end
    self.move = choice
    @history << @move
  end
end
