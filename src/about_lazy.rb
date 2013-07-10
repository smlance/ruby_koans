require File.expand_path(File.dirname(__FILE__) + '/neo')

# Our universe is infinite in its complexity. 
# Yet we as humans have finite energy. 
# In order to deal with an infinite universe, we must be lazy. 
# Expend as little energy as possible, yet gain as much as possible. 
# That is true enlightenment. 

class AboutLazyEnumeration < Neo::Koan

  class Num
    def even
      i = 0
      loop do
        yield i
        i += 2 
      end
    end
  end
 
  def test_large_range_without_lazy # Move to different file? To show time?
    range = (1..19999999)
    array = range.select{|n| n % 2 == 0 }.first(5)
    assert_equal __([2,4,6,8,10]), array
    # Meditate on how long it took to return an answer. 
    # We can surely be lazier than that.
  end

  def test_large_range_with_lazy 
    range = (1..19999999).__(lazy)
    array = range.select{|n| n % 2 == 0 }.first(5)
    assert_equal __([2,4,6,8,10]), array
    # Much better timing. 
  end

  def test_infinite_range 
    range = 1..Float::INFINITY
    # To be lazy or not to be lazy, that is the question.
    collection = range.__(lazy).collect{ |x| x }.first(5)
    # collection is an array
    assert_equal __([1, 2, 3, 4, 5]), collection
  end 

  def test_size
    array = [1, 2, 3, 4]
    size = (array * 2).size
    assert_equal __(8), size
  end

	def test_lazy_select
    num = Num.new
    enums = []
    enums = num.enum_for(:even).__(lazy).select{|i| i < 3 }.first(2)
    assert_equal __([0, 2]), enums
  end
end
