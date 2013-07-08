require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutRefinements < Neo::Koan

    class Dog

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

    module ActsLikeTiger

      refine Dog do
        def bark
          "ROAR"
        end

        def runs_fast
          true
        end
      end

    end

    def test_refinements_not_normally_visible
      fido = Dog.new

      assert_equal __("WOOF"), fido.bark
      assert_equal __(false), fido.runs_fast
      # TODO: Need to implement NoMethodError in this part of the code...
    end

    def test_refinements_require_module_use
      using ActsLikeTiger
      fido = Dog.new

      assert_equal __("ROAR"), fido.bark
      assert_equal __(true), fido.runs_fast
    end

  end
