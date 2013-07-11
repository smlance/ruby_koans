require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutVariableScope < Neo::Koan
		def bark
      barking = "ruff!"  
		end

	def test_barking_is_not_available_in_the_current_scope
		assert_raise(___(NameError)) do
			barking
		end
	end

  def test_we_can_get_barking_by_calling_def
    assert_equal __("ruff!"), bark
  end

  inaccessible = "Outside our universe"
  def test_defs_cannot_access_variables_outside_scope
    # defined? does not return true or false
    assert_equal __(nil), defined? inaccesible
  end

  # ------------------------------------------------------

  def test_blocks_can_access_variables_outside_scope 
    test = "hi"
    (1..2).each do
      test = "hey"
    end
    assert_equal __("hey"), test    
  end

  def test_block_variables_cannot_be_accessed_outside_scope
    (1..2).each do
      x = 0 
    end
    assert_equal __(nil), defined? x
  end

  # ------------------------------------------------------

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
    # Things may appear easier than they actually are.  
    assert_equal __(10), Mouse.count
  end

  # Meditate on the following: 
  # What is the difference between a class variable and instance variable?

  # ------------------------------------------------------
  
  $anywhere = "anywhere"
  def test_global_variables_can_be_accessed_from_anywhere
    assert_equal __("anywhere"), $anywhere    
  end

  def test_global_variables_can_be_changed_from_anywhere
    # from within a def
    $anywhere = "here"
    assert_equal __("here"), $anywhere

    # from within a block
    (1..2).each do
      $anywhere = "hey"
    end
    assert_equal __("hey"), $anywhere
  end

end
