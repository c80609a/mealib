module Dry
  module Rules
    class MinLength < Dry::Rules::Binary

      def valid?
        return true if left.size >= right
        add_error
        false
      end


      def name
        'min_length'
      end

    end
  end
end
