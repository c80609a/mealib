module Dry
  module Rules
    class LessThanOrEqual < Dry::Rules::Binary

      def valid?
        return true if left <= right
        add_error
        false
      end


      def name
        'lt_eq'
      end

    end
  end
end
