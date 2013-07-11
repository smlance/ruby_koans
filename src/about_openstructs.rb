require File.expand_path(File.dirname(__FILE__) + '/neo')

require 'ostruct'
# We must require 'ostruct' to use OpenStructs.

class AboutOpenStructs < Neo::Koan
  
  def test_openstructs_behave_like_hashes
    person = OpenStruct.new
    person.name = "Joe"
    person.age = 25
    person.siblings = 3
    
    person_hash = person.to_h
    assert_equal (__({:name => "Joe", :age => 25, :siblings => 3})), person_hash
    # NOTE: The parentheses are important.
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

  def test_openstructs_also_understand_accessor_reading_and_writing
    person = OpenStruct.new
    person.name = "Joe"
    person.age = 25
    person.siblings = 3

    assert_equal __("Joe"), person.name

    person.eye_color = "brown"
    assert_equal __("brown"), person.eye_color
  end

  def test_openstruct_properties_can_be_mass_assigned
    person = OpenStruct.new(:name => "Joe", :age => 25, :siblings => 3)

    assert_equal __("Joe"), person.name
    assert_equal __(25), person[:age]
    assert_equal __(3), person[:siblings]
  end

  def test_hash_conversions_from_openstruct
    person = OpenStruct.new(:name => "Joe", :age => 25, :siblings => 3)

    assert_equal __(Hash), person.to_h.class

    assert_raise (__(TypeError)) do
      Hash(person).class
    end
  end

  Person = Struct.new(:name, :age, :siblings)

  def test_hash_conversions_from_struct
    person = Person.new("Joe", 25, 3)

    assert_equal __(Hash), person.to_h.class

    assert_raise (__(TypeError)) do
      Hash(person).class
    end
  end

  def test_openstructs_can_be_modified_after_creation
    person = OpenStruct.new(:name => "Joe", :age => 25, :siblings => 3)
    
    person.name = "Emily"
    assert_equal __("Emily"), person[:name]

    person.job = "Professor"
    assert_equal __("Professor"), person.job

    person.delete_field(:name)
    person.delete_field(:siblings)
    assert_equal __("Professor"), person.delete_field(:job)

    assert_equal __("#<OpenStruct age=25>"), person.inspect
  end

  def test_struct_attributes_but_not_members_can_be_modified_after_creation
    person = Person.new("Simon", 30, 4)

    person.name = "Chloe"
    assert_equal __("Chloe"), person.name

    assert_raise __(NameError) do
      person[:job] = "Sailor"
    end

    assert_raise __(NoMethodError) do
      person.job = "Musician"
    end
  end

  # THINK ABOUT IT:
  #
  # What are the crucial differences between Structs and OpenStructs?

end
