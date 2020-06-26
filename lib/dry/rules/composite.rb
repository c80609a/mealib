module Dry
  module Rules
    class Composite < Dry::Rules::Binary

      private


      def lt
        @lt ||= left.clone
      end


      def rt
        @rt ||= right.clone
      end

    end
  end
end
