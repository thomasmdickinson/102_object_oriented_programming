# 1.

# You are given the following code:

  # class Oracle
  #   def predict_the_future
  #     "You will " + choices.sample
  #   end
  #
  #   def choices
  #     ["eat a nice lunch", "take a nap soon", "stay at work late"]
  #   end
  # end

# What is the result of calling

  # oracle = Oracle.new
  # oracle.predict_the_future

"You will eat a nice lunch"    # One of these
"You will take a nap soon"
"You will stay at work late"

# 2.
# We have an Oracle class and a RoadTrip class that inherits from the
# Oracle class.

  # class Oracle
  #   def predict_the_future
  #     "You will " + choices.sample
  #   end
  #
  #   def choices
  #     ["eat a nice lunch", "take a nap soon", "stay at work late"]
  #   end
  # end
  #
  # class RoadTrip < Oracle
  #   def choices
  #     ["visit Vegas", "fly to Fiji", "romp in Rome"]
  #   end
  # end

# What is the result of the following:

  # trip = RoadTrip.new
  # trip.predict_the_future

"You will visit Vegas"    # One of these
"You will fly to Fiji"
"You will romp in Rome"

# 3.
# How do you find where Ruby will look for a method when that method is called?
# How can you find an object's ancestors?

"you can call ancestors on the object's class."

  # module Taste
  #   def flavor(flavor)
  #     puts "#{flavor}"
  #   end
  # end
  #
  # class Orange
  #   include Taste
  # end
  #
  # class HotSauce
  #   include Taste
  # end

# What is the lookup chain for Orange and HotSauce?

" ---Orange lookup chain---
 Orange
 Taste
 Object
 Kernel
 BasicObject
 ---HotSauce lookup chain---
 HotSauce
 Taste
 Object
 Kernel
 BasicObject"

# 4.
# What could you add to this class to simplify it and remove two methods from
# the class definition while still maintaining the same functionality?

  # class BeesWax
  #   def initialize(type)
  #     @type = type
  #   end
  #
  #   def type
  #     @type
  #   end
  #
  #   def type=(t)
  #     @type = t
  #   end
  #
  #   def describe_type
  #     puts "I am a #{@type} of Bees Wax"
  #   end
  # end

class BeesWax
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end

# 5.
# There are a number of variables listed below. What are the different types
# and how do you know which is which?

excited_dog = "excited dog"     # local variable    - no prefix
@excited_dog = "excited dog"    # instance variable - prefix @
@@excited_dog = "excited dog"   # class variable    - prefix @@

# 6.
# If I have the following class:

  # class Television
  #   def self.manufacturer
  #     # method logic
  #   end
  #
  #   def model
  #     # method logic
  #   end
  # end

# Which one of these is a class method (if any) and how do you know?
# How would you call a class method?

"self.manufacturer is a class method, because it has the self prefix.
You would call it on the class itself, like so:"

Television.manufacturer

# 7.
# If we have a class such as the one below:

  # class Cat
  #   @@cats_count = 0
  #
  #   def initialize(type)
  #     @type = type
  #     @age  = 0
  #     @@cats_count += 1
  #   end
  #
  #   def self.cats_count
  #     @@cats_count
  #   end
  # end

# Explain what the @@cats_count variable does and how it works.
# What code would you need to write to test your theory?

"@@cats_count is a class variable storing the # of Cat objects in existence."

puts Cat.cats_count
a = Cat.new('calico')
puts Cat.cats_count
b = Cat.new('lion')
c = Cat.new('animagus')
puts Cat.cats_count

# 8.
# If we have this class:

  # class Game
  #   def play
  #     "Start the game!"
  #   end
  # end

# And another class:

  # class Bingo
  #   def rules_of_play
  #     #rules of play
  #   end
  # end

# What can we add to the Bingo class to allow it to inherit the play method
# from the Game class?

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

# 9.
# If we have this class:

  # class Game
  #   def play
  #     "Start the game!"
  #   end
  # end

  # class Bingo < Game
  #   def rules_of_play
  #     #rules of play
  #   end
  # end

# What would happen if we added a play method to the Bingo class, keeping in
# mind that there is already a method of this name in the Game class that the
# Bingo class inherits from.

"When the method play is called on a Bingo object, the method in the Bingo
class will be executed rather than the one in the Game class, because the
lookup chain specifies that Bingo is checked before Game."

# 10.
# What are the benefits of using Object Oriented Programming in Ruby?
# Think of as many as you can.

" - It allows for the programmer to think about their code in terms of
    useful abstractions
  - It allows for code to be organized so that related methods are found
    together within the code and namespaced so that they do not come into
    conflict with similarly-named methods elsewhere
  - It allows for code to be reused across similar applications (i.e., a Poker
    game and a Blackjack game can use the same Card and Deck classes)
"
