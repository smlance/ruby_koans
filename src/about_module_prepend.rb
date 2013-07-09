require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutModulePrepend < Neo::Koan

  # Below is copied from about_modules.rb
  module Nameable
    def set_name(new_name)
      @name = new_name
    end

    def here
      :in_module
    end
  end

  # End of copied region
  # ------------------------------------------------------------------

  # Should probably belong to about_modules.
  # Below is copied from about_modules.rb (except for prepend line)
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
