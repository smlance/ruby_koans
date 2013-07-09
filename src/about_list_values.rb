require File.expand_path(File.dirname(__FILE__) + '/neo')

# NOTE:
# Either put this in about_array_assignment.rb, about_arrays.rb, or put them
# in a separate file so that the "out of range values returns nil"
# functionality is fully shown. Consider, however, that this file also shows
# how this aspect of #values_at works for hashes -- so it would not be
# appropriate for about_array*.rb. Thus, a different file (such as this one)
# is likely okay.
#
# Also, adding this file will require three lines in path_to_enlightenment.rb,
# and adding the contents of this file to an about_*.rb will require
# a conditional check for Ruby version 2.

class AboutListValues < Neo::Koan

  array = [1, 2, 3, 4, 5]

  def test_out_of_range_value_returns_nil
    a = array.values_at(3..5)
    assert_equal __([4, 5, nil]), a
  end
    
  def test_out_of_range_values_returns_nil
    a = array.values_at(3..7)
    assert_equal __([4, 5, nil, nil, nil]), a

    b = array.values_at(0, 1, 5, 6)
    assert_equal __([1, 2, nil, nil]), b

    c = array.values_at(3..5, 1..-2)
    assert_equal __([4, 5, nil, 2, 3, 4]), c
  end

  def test_out_of_range_hash_values_also_return_nil
    hash = { :one => "uno", :two => "dos" }
    assert_equal __(["uno", "dos"]), hash.values

    a = hash.values_at(:one, :two)
    assert_equal __(["uno", "dos"]), a

    b = hash.values_at(:one, :two, :three)
    assert_equal __(["uno", "dos", "tres"]), b

    c = hash.values_at(:one, :two, :three, :four)
    assert_equal __(["uno", "dos", "tres"]), c
  end

end
