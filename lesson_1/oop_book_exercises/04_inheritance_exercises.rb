# 1.
# Create a superclass called Vehicle for your MyCar class to inherit from and
# move the behavior that isn't specific to the MyCar class to the superclass.
# Create a constant in your MyCar class that stores information about the
# vehicle that makes it different from other types of Vehicles.

# Then create a new class called MyTruck that inherits from your superclass
# that also has a constant defined that separates it from the MyCar class in
# some way.

# 2.
# Add a class variable to your superclass that can keep track of the number of
# objects created that inherit from the superclass. Create a method to print
# out the value of this class variable as well.

# 3.
# Create a module that you can mix in to ONE of your subclasses that describes a
# behavior unique to that subclass.

# 5.
# Move all of the methods from the MyCar class that also pertain to the MyTruck
# class into the Vehicle class. Make sure that all of your previous method calls
# are working when you are finished.

# 6.
# Write a method called age that calls a private method to calculate the age of
# the vehicle. Make sure the private method is not available from outside of the
# class. You'll need to use Ruby's built-in Time class to help.

module Carryable
  def carry
    "I can carry things around."
  end
end

class Vehicle
  attr_accessor :color, :model, :year
  attr_reader :speed

  @@number_of_vehicles = 0

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
    @@number_of_vehicles += 1
  end

  def age
    "This vehicle is #{age_of_vehicle} years old."
  end

  def self.gas_mileage(miles, gallons)
    puts "#{miles / gallons} miles to the gallon!"
  end

  def self.count_vehicles
    "#{@@number_of_vehicles} vehicles exist!"
  end

  def speed_up(num)
    @speed += num
    puts "The vechicle has sped up by #{num} mph to #{@speed}."
  end

  def brake(num)
    @speed -= num
    puts "The vechicle has slowed down by #{num} mph to #{@speed}."
  end

  def shut_down
    @speed = 0
    puts "The vechicle is off."
  end

  def spray_paint(new_color)
    self.color = new_color
    puts "The vechicle is now #{color}."
  end

  private

  def age_of_vehicle
    Time.now.year - self.year
  end

end

class MyCar < Vehicle

  NUMBER_OF_AXLES = 2

  def to_s
    "This car is a #{@color} #{@year} #{@model}, and it's going #{@speed} miles per hour."
  end
end

class MyTruck < Vehicle
  include Carryable
  NUMBER_OF_AXLES = 3

  def to_s
    "This truck is a #{@color} #{@year} #{@model}, and it's going #{@speed} miles per hour."
  end
end

camry = MyCar.new(2007, 'white', 'camry')
camry.speed_up(45)
camry.brake(8)
camry.speed
camry.shut_down
camry.spray_paint("blue")
MyCar.gas_mileage(103,6)
puts camry.age

# 4.
# Print to the screen your method lookup for the classes that you have created.

puts "---MyTruck method lookup--"
puts MyTruck.ancestors
puts "---MyCar method lookup--"
puts MyCar.ancestors
puts "---Vehicle method lookup--"
puts Vehicle.ancestors

# 7.
# Create a class 'Student' with attributes name and grade. Do NOT make the
# grade getter public, so joe.grade will raise an error. Create a
# better_grade_than? method, that you can call like so...

  # puts "Well done!" if joe.better_grade_than?(bob)

class Student
  def initialize(n, g)
    @name  = n
    @grade = g
  end

  def better_grade_than?(someone)
    self.grade > someone.grade
  end

  protected

  def grade
    @grade
  end
end

bob = Student.new('Bob', 85)
joe = Student.new('Joe', 86)
puts "Well done!" if joe.better_grade_than?(bob)

# 8.
# Given the following code...

  # bob = Person.new
  # bob.hi

# And the corresponding error message...

  # NoMethodError: private method `hi' called for #<Person:0x007ff61dbb79f0>
  # from (irb):8
  # from /usr/local/rvm/rubies/ruby-2.0.0-rc2/bin/irb:16:in `<main>'

# What is the problem and how would you go about fixing it?

"The problem is that the method hi is listed below the word 'private' and cannot
be called. ONe way to fix it would be to change this, the other way to fix it
would be to instead create a public method which calls the hi method from inside
the object."
