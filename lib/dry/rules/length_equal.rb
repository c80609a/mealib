module Dry
  module Rules
    class LengthEqual < Dry::Rules::Binary

      def valid?
        return true if left.size == right
        add_error
        false
      end


      def name
        'length_equal'
      end

    end
  end
end
