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
#    person.name = "Joe"
 #   person.age = 25
  #  person.siblings = 3

    assert_equal __(25), person[:age]
  end

end
