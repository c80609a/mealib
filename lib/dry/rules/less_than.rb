module Dry
  module Rules
    class LessThan < Dry::Rules::Binary

      def valid?
        return true if left < right
        add_error
        false
      end


      def name
        'lt'
      end

    end
  end
end
