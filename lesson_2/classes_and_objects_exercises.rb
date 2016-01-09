#1.
# Given the below usage of the Person class, code the class definition.

class Person
  attr_accessor :name
  def initialize(n)
    @name = n
  end
end

  bob = Person.new('bob')
  bob.name                  # => 'bob'
  bob.name = 'Robert'
  bob.name                  # => 'Robert'

# 2.
# Modify the class definition from above to facilitate the following methods.
# Note that there is no name= setter method now.

class Person
  attr_accessor :first_name, :last_name
  def initialize(n)
    name_arr = n.split
    @first_name = name_arr[0]
    @last_name = name_arr.size > 1 ? name_arr.last : ''
  end

  def name
    name = "#{first_name} #{last_name}".strip
  end
end

  bob = Person.new('Robert')
  bob.name                  # => 'Robert'
  bob.first_name            # => 'Robert'
  bob.last_name             # => ''
  bob.last_name = 'Smith'
  bob.name                  # => 'Robert Smith'

# 3.
# Now create a smart name= method that can take just a first name or a full
# name, and knows how to set the first_name and last_name appropriately.

class Person
  attr_accessor :first_name, :last_name
  def initialize(n)
    name_arr = n.split
    @first_name = name_arr[0]
    @last_name = name_arr.size > 1 ? name_arr.last : ''
  end

  def name
    name = "#{first_name} #{last_name}".strip
  end

  def name=(n)
    name_arr = n.split
    @first_name = name_arr[0]
    @last_name = name_arr.size > 1 ? name_arr.last : ''
  end
end

  bob = Person.new('Robert')
  bob.name                  # => 'Robert'
  bob.first_name            # => 'Robert'
  bob.last_name             # => ''
  bob.last_name = 'Smith'
  bob.name                  # => 'Robert Smith'

  bob.name = "John Adams"
  bob.first_name            # => 'John'
  bob.last_name             # => 'Adams'

# 4.
# Using the class definition from step #3, let's create a few more people --
# that is, Person objects.

  bob = Person.new('Robert Smith')
  rob = Person.new('Robert Smith')

# If we're trying to determine whether the two objects contain the same name,
# how can we compare the two objects?

bob.name == rob.name

# 5.
# Continuing with our Person class definition, what does the below print out?

  # bob = Person.new("Robert Smith")
  # puts "The person's name is: #{bob}"

"This will print out the object bob with object id (which will not be too
pretty unless a specific to_s method is defined.)"

# Let's add a to_s method to the class:

  # class Person
  #   # ... rest of class omitted for brevity
  #
  #   def to_s
  #     name
  #   end
  # end

# Now, what does the below output?

  # bob = Person.new("Robert Smith")
  # puts "The person's name is: #{bob}"

"The person's name is: Robert Smith"
