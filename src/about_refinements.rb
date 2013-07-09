require File.expand_path(File.dirname(__FILE__) + '/neo')

# Maybe include a real monkeypatching instance (like refining String
# or FixNum for some purpose.)

module ActsLikeTiger
  # We will add to this module below.
end

class Dog
  
  include ActsLikeTiger
  # What will the ActsLikeTiger module do to instances of Dog?

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

class SpecificDog < Dog

end

module ActsLikeTiger

  refine SpecificDog do
    def bark
      "ROAR"
    end

    def runs_fast
      "I do run fast!"
    end
  end

end

using ActsLikeTiger
# What happens if ActsLikeTiger is not used?

class AboutRefinements < Neo::Koan

  def test_refinements_not_normally_visible
    fido = Dog.new

    assert_equal __("WOOF"), fido.bark
    assert_equal __(false), (fido.respond_to? :runs_fast)
  end

  def test_refinements_visible_to_refined_classes_when_using_refinements
    fido = SpecificDog.new

    assert_equal __("ROAR"), fido.bark
    assert_equal __("I do run fast!"), fido.runs_fast

    assert_equal __(false), (fido.respond_to? :runs_fast)

    # THINK ABOUT IT:
    #
    # The instance of the SpecificDog class makes a claim about whether
    # it responds to #runs_fast, and it then tries to respond to it.
    # Why are the claim and the action not in agreement with one another?

  end

end
