require File.expand_path(File.dirname(__FILE__) + '/neo')

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

  def test_infinite_range 
    range = 1..Float::INFINITY
    collection = range.lazy.collect{ |x| x }.first(5)
    # collection is an array
    assert_equal __, collection
  end 

  def test_files
    file = 'example_file.txt'
    lines = File.open(file).lazy.each.map(&:chomp).reject(&:empty?).take(3).force
    assert_equal __, lines
  end

  def test_lazy_select
    num = Num.new

    enums = []
    num.enum_for(:even).lazy.select{|i| i < 3 }.take(2).each{|i| enums << i} 
    assert_equal __, enums
  end

  def test_lazy_again
    num = Num.new

    enums = []
    # How can we ensure that this does not go into an infinite loop?
    num.enum_for(:even).__.select{|i| i < 5 }.take(3).each{|i| enums << i} 
    assert_equal __, enums
  end
end
