class Participant
  attr_accessor :name, :hand, :score

  def initialize
    @hand = Hand.new
    @score = 0
  end

  def busted?
    @hand.total > 21
  end

  def show_hand
    puts "#{@name.upcase}'S HAND".center(30)
    puts "=============================="
    hand.display
    puts "=============================="
    puts "             total: #{hand.hole? ? '???' : hand.total}"
    puts ''
  end

  def clear_hand
    @hand = Hand.new
  end
end

class Player < Participant
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

  def hit?
    choice = ''
    loop do
      puts 'Hit or stay?'
      choice = gets.chomp.downcase
      break if %w(hit stay).include?(choice)
      puts "That's not a thing."
      sleep 1
    end
    choice == 'hit'
  end
end

class Dealer < Player
  POSSIBLE_NAMES = %w(GLaDOS BB-8 K-9 Marvin HAL WALL-E Watson)

  def pick_name
    @name = POSSIBLE_NAMES.sample
  end

  def hit?
    sleep 1
    if @hand.total < 17
      puts "I'll hit."
      sleep 1
      return true
    else
      puts "I'll stay."
      sleep 2
      return false
    end
  end
end
