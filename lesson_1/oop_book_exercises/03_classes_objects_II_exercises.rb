# 1.
# Add a class method to your MyCar class that calculates the gas mileage of
# any car.

# 2.
# Override the to_s method to create a user friendly print out of your object.

class MyCar
  attr_accessor :color
  attr_reader :year

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
  end

  def self.gas_mileage(miles, gallons)
    puts "#{miles / gallons} miles to the gallon!"
  end

  def to_s
    "This is a #{@color} #{@year} #{@model}, and it's going #{@speed} miles per hour."
  end

  def speed_up(num)
    @speed += num
    puts "The cars has sped up by #{num} mph to #{@speed}."
  end

  def brake(num)
    @speed -= num
    puts "The cars has slowed down by #{num} mph to #{@speed}."
  end

  def shut_down
    @speed = 0
    puts "The car is off."
  end

  def spray_paint(new_color)
    self.color = new_color
    puts "The car is now #{color}."
  end
end

camry = MyCar.new(2007, 'white', 'Toyota Camry')
puts camry
puts MyCar.gas_mileage(400,13)

# 3.
# When running the following code...

  # class Person
  #   attr_reader :name
  #   def initialize(name)
  #     @name = name
  #   end
  # end
  #
  # bob = Person.new("Steve")
  # bob.name = "Bob"

# We get the following error...

  # test.rb:9:in `<main>': undefined method `name=' for
  #   #<Person:0x007fef41838a28 @name="Steve"> (NoMethodError)

# Why do we get this error and how to we fix it?

"attr_reader makes the name read-only. attr_accessor makes it suitable for
reading and writing."

class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"
