module Dry
  module Rules
    class NotEqual < Dry::Rules::Binary

      def valid?
        return true unless left.eql?(right)
        add_error
        false
      end


      def name
        'not_eq'
      end

    end
  end
end
