require File.expand_path(File.dirname(__FILE__) + '/neo')

# For OpenStructs
require 'ostruct'

class AboutOpenStructs < Neo::Koan
  
  # Might be better to put this in about_hashes.rb.
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

  Person = Struct.new(:name, :age, :siblings)

  def test_hash_conversions_from_struct
    person = Person.new("Joe", 25, 3)

    assert_equal __(Hash), person.to_h.class

    # Maybe add this to another koan or a hint suggesting that you can't
    # convert a Struct to a Hash using Hash()?
    assert_raise (__(TypeError)) do
      Hash(person).class
    end
  end

end
