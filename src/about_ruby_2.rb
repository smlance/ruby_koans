require File.expand_path(File.dirname(__FILE__) + '/neo')

# NOTE:
# This file contains single simple koans for different Ruby 2.0
# functionalities. They will later be separated and added to other
# files or combined into different, new files (with appropriate
# changes / additions to path_to_enlightenment.rb).

# For OpenStructs
require 'ostruct'

class AboutArrays < Neo::Koan

  def test_openstructs_behave_like_hashes
    person = OpenStruct.new
    person.name = "Joe"
    person.age = 25
    person.siblings = 3
    
    person_info = person.each_pair { |key, value| print key, ", ", value, "; "  }

    assert_equal __("name, Joe; age, 20; siblings, 3;"), person_info
  end

  def test_openstructs_understand_symbols
    person = OpenStruct.new
    person.name = "Joe"
    person.age = 25
    person.siblings = 3

    assert_equal __("Joe"), person[:name]

    person[:eye_color] = "brown"
    assert_equal __("brown"), person[:eye_color]
  end

  def test_openstructs_can_be_initialized_like_hashes
    person = OpenStruct.new(:name => "Joe", :age => 25, :siblings => 3)

    assert_equal __(25), person[:age]
  end

  def test_hash_conversions_from_openstruct
    person = OpenStruct.new(:name => "Joe", :age => 25, :siblings => 3)

    assert_equal __(Hash), person.to_h.class
    assert_equal __(Hash), Hash(person).class
  end

  # def test_hash_conversions_from_struct
  #   person = Struct.new(:name => "Joe", :age => 25, :siblings => 3)

  #   assert_equal __(Hash), person.to_h.class
  #   assert_equal __(Hash), Hash(person).class
  # end
  
  # It turns out Structs don't behave this way, and we need to add them
  # separately (maybe to a file of their own?)

  # ------------------------------------------------------------------

  # Below is copied from about_modules.rb
  module Nameable
    def set_name(new_name)
      @name = new_name
    end

    def here
      :in_module
    end
  end

  def test_cant_instantiate_modules
    assert_raise(___(NoMethodError)) do
      Nameable.new
    end
  end

  # ------------------------------------------------------------------

  class Dog
    prepend Nameable # The crucial change; prepend rather than include

    attr_reader :name

    def initialize
      @name = "Fido"
    end

    def bark
      "WOOF"
    end

    def here
      :in_object
    end
  end
  # End of what's copied from about_modules.rb

  def test_prepended_module_methods_override_class_methods
    fido = Dog.new
    assert_equal __(:in_module), fido.here
  end

  # ------------------------------------------------------------------

  def test_symbol_array_literals
    item = %i{ monday tuesday wednesday }
    assert_equal __([:monday, :tuesday, :wednesday]), item

    item = %i{ monday, tuesday, wednesday }
    assert_equal __([:"monday,", :"tuesday,", :wednesday]), item
  end

  def test_symbol_array_literals_with_interpolation
    item = %I{ #{"monday" + " tuesday"} wednesday }
    # Note the capital 'i' for interpolation!

    assert_equal __([:"monday tuesday", :wednesday]), item
  end

  # ------------------------------------------------------------------



end
