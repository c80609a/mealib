module Dry
  module Rules
    class Equal < Dry::Rules::Binary

      def valid?
        return true if left.eql?(right)
        add_error
        false
      end


      def name
        'eq'
      end

    end
  end
end
