module Dry
  module Rules
    class And < Dry::Rules::Composite

      def valid?
        left.valid? && right.valid? ? true : false
      end

    end
  end
end
