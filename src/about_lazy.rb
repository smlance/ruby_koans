require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutLazy < Neo::Koan

  class Num
    def even
      i = 0
      loop do
        yield i
        i += 2 
      end
    end

    def odd 
      i = 1
      loop do	
        yield i 
        i += 2
      end
    end
  end

  def test_infinite_range 
    range = 1..Float::INFINITY
    collection = range.lazy.collect { |x| x }.first(5)
    # collection is an array
    assert_equal __([1, 2, 3, 4, 5]), collection
  end 

  def test_files
    file = 'example_file.txt'
    lines = File.open(file).lazy.each.map(&:chomp).reject(&:empty?).take(3).force
    assert_equal __(["this", "is", "a"]), lines
  end
end
