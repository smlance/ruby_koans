require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutVariableScope < Neo::Koan
	class Dog
		def bark
      barking = "ruff!"  
      return barking
		end
	end

	def test_barking_is_not_available_in_the_current_scope
		assert_raise(___(NameError)) do
			barking
		end
	end

  def test_we_can_get_barking_by_making_new_class  
    joe = Dog.new
    assert_equal __("ruff!"), joe.bark
  end

  class Mouse
    @@total = 0
    def initialize(n)
      @name = n 
      @@total += 1 
    end

    def name
      @name
    end

    def Mouse.count
      @@total
    end
  end

  def test_instance_variable 
    oscar = Mouse.new("oscar")
    assert_equal __("oscar"), oscar.name 
  end

  def test_class_variable
    (1..9).each { |i| Mouse.new("#{i}") }
    # Be careful. How many mice did we create altogether? 
    # Hint:  
    assert_equal __(10), Mouse.count
  end

  # Meditate on the following: 
  # What is the difference between a class variable and instance variable?
  
end
