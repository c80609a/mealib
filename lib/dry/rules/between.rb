module Dry
  module Rules
    class Between < Dry::Rules::Binary

      def valid?
        return true if right.include? left
        add_error
        false
      end


      def name
        'between'
      end

    end
  end
end
