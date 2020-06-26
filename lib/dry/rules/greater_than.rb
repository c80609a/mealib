module Dry
  module Rules
    class GreaterThan < Dry::Rules::Binary

      def valid?
        return true if left > right
        add_error
        false
      end


      def name
        'gt'
      end

    end
  end
end
