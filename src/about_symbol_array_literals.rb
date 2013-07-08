require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutSymbolArrayLiterals < Neo::Koan

  # If added to about_symbols.rb, prefix with a conditional based on
  # the version the user is using (if using 2.0, do these tests)
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

end
