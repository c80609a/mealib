module Dry
  module Rules
    class GreaterThanOrEqual < Dry::Rules::Binary

      def valid?
        return true if left >= right
        add_error
        false
      end


      def name
        'gt_eq'
      end

    end
  end
end
