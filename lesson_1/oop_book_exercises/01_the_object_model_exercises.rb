# 1.
# How do we create an object in Ruby?

"In ruby we create an object by invoking the 'new' method on the class."

# Give an example of the creation of an object.

class Pokemon
end

pikachu = Pokemon.new

# 2.
# What is a module? What is its purpose? How do we use them with our classes?

"A module is a unit containing a set of behaviors that are coded into a unit
which can be included in a class. They are not defined as part of a certain
class but might be used by many classes. They are used by including them as a
mixin."

# Create a module for the class you created in exercise 1
# and include it properly.

module DamageCalc
  def super_effective
    puts "It's super effective!"
  end
end

class Pokemon
  include DamageCalc
end

pikachu = Pokemon.new
pikachu.super_effective
