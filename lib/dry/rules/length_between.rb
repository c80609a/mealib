module Dry
  module Rules
    class LengthBetween < Dry::Rules::Binary

      def valid?
        return true if right.include? left.size
        add_error
        false
      end


      def name
        'length_between'
      end

    end
  end
end
