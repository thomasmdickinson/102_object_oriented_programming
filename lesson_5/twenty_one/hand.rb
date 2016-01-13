class Hand
  attr_accessor :cards, :has_hole

  def initialize
    @cards = []
    @has_hole = false
  end

  def display
    @cards.each do |card|
      if self.hole? && @cards.index(card) == 0
        puts "  One card face-down."
      else
        puts "  " + card.to_s
      end
    end
  end

  def hole?
    @has_hole
  end

  def total
    total_value = 0
    @cards.each do |card|
      total_value += card.determine_point_value
    end
    high_aces = @cards.count { |card| card.value == 'Ace' }
    while total_value > 21 && high_aces > 0
      total_value -= 10
      high_aces -= 1
    end
    total_value
  end
end
