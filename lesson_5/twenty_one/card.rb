class Card
  SUITS = %w(Hearts Diamonds Spades Clubs)
  VALUES = (2..10).to_a + %w(Jack Queen King Ace)

  attr_accessor :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def to_s
    "#{value} of #{suit}"
  end

  def determine_point_value
    if @value.is_a?(Integer)
      @value
    elsif @value == 'Ace'
      11
    else
      10
    end
  end
end
