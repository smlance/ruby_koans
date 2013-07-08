require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutModulePrepend < Neo::Koan
  # Should probably belong to about_modules.
  class Dog
    prepend Nameable # The crucial change; prepend rather than include

    attr_reader :name

    def initialize
      @name = "Fido"
    end

    def bark
      "WOOF"
    end

    def here
      :in_object
    end
  end
  # End of what's copied from about_modules.rb

  def test_prepended_module_methods_override_class_methods
    fido = Dog.new
    assert_equal __(:in_module), fido.here
  end

end
