require File.expand_path(File.dirname(__FILE__) + '/neo')

class Num
	def even
		i = 0
		loop do
			yield i
			i += 2 
		end
	end
end

class AboutLazy < Neo::Koan

	def test_infinite_range 
		range = 1..Float::INFINITY
		collection = range.lazy.collect{ |x| x }.first(5)
		# collection is an array
		assert_equal __([1, 2, 3, 4, 5]), collection
	end 

	def test_files
    file = 'example_file.txt'
    lines = File.open(file).lazy.each.map(&:chomp).reject(&:empty?).take(3).force
    assert_equal __(["this", "is", "a"]), lines
	end

	def test_lazy_select
    num = Num.new

    enums = []
    num.enum_for(:evens).lazy.select{|i| i < 3 }.take(2).each{|i| enums << i} 
    assert_equal __([0, 2]), enums
  end

  def test_lazy_again
    num = Num.new

    enums = []
    # How can we assure that this does not go into an infinite loop?
    num.enum_for(:evens).__(lazy).select{|i| i < 5 }.take(3).each{|i| enums << i} 
    assert_equal __([0, 2, 4]), enums
	end
end