module Dry
  module Rules
    class Included < Dry::Rules::Binary

      def valid?
        return true if right.include?(left)
        add_error
        false
      end


      def name
        'included'
      end

    end
  end
end
