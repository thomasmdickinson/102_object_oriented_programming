class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    Card::SUITS.each do |s|
      Card::VALUES.each { |v| @cards << Card::Card.new(s, v) }
    end
  end

  def shuffle
    @cards.shuffle!
  end

  def deal(num, player, hidden=false)
    num.times do
      player.hand.cards << @cards.pop
    end
    player.hand.has_hole = true if hidden
  end
end
