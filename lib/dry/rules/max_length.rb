module Dry
  module Rules
    class MaxLength < Dry::Rules::Binary

      def valid?
        return true if left.size <= right
        add_error
        false
      end


      def name
        'max_length'
      end

    end
  end
end
