module Dry
  module Rules
    class Format < Dry::Rules::Binary

      def valid?
        return true if left.to_s.match(right).present?
        add_error
        false
      end


      def name
        'format'
      end

    end
  end
end
