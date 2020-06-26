module Dry
  module Rules
    class Binary < Dry::Rule

      def right
        args[:right]
      end


      def left
        value
      end

    end
  end
end
