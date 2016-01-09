class MyCar
  attr_accessor :color
  attr_reader :year

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
  end

  def describe
    puts "This is a #{@color} #{@year} #{@model}, and it's going #{@speed} miles per hour."
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
camry.describe
camry.speed_up(45)
camry.brake(13)
camry.describe
camry.shut_down
camry.spray_paint('blue')
camry.describe
puts camry.year


# 1.
# Create a class called MyCar. When you initialize a new instance or object of
# the class, allow the user to define some instance variables that tell us the
# year, color, and model of the car. Create an instance variable that is set to
# 0 during instantiation of the object to track the current speed of the car as
# well. Create instance methods that allow the car to speed up, brake, and shut
# the car off.

# 2.
# Add an accessor method to your MyCar class to change and view the color of
# your car. Then add an accessor method that allows you to view, but not modify,
# the year of your car.

# 3.
# You want to create a nice interface that allows you to accurately describe the
# action you want your program to perform. Create a method called spray_paint
# that can be called on an object and will modify the color of the car.
