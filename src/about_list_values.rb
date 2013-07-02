require File.expand_path(File.dirname(__FILE__) + '/neo')

# NOTE:
# Either put this in about_array_assignment.rb, or put them
# in a separate file so that the "out of range values returns nil"
# functionality is fully shown

class AboutListValues < Neo::Koan

  def test_out_of_range_value_returns_nil
    array = [1, 2, 3, 4, 5]

    array_a = array.values_at(3..5)
    assert_equal __([4, 5, nil]), array_a
  end
    
  def test_out_of_range_values_returns_nil
    array_b = array.values_at(3..7)
    assert_equal __([4, 5, nil, nil, nil]), array_b

    array_c = array.values_at(0, 1, 5, 6)
    assert_equal __([1, 2, nil, nil]), array_c

    array_d = array.values_at(3..5, 1..-2)
    assert_equal __([4, 5, nil, 2, 3, 4]), array_d
  end

  def test_out_of_range_hash_values_also_return_nil
    hash = { :one => "uno", :two => "dos" }
    assert_equal __(["uno", "dos"]), hash.values

    array_e = hash.values_at(:one, :two)
    assert_equal __(["uno", "dos"]), array_e

    array_f = hash.values_at(:one, :two, :three)
    assert_equal __(["uno", "dos", "tres"]), array_f

    array_g = hash.values_at(:one, :two, :three, :four)
    assert_equal __(["uno", "dos", "tres"]), array_g
  end

end
