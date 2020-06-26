module Dry
  module Rules
    class Collection < Dry::Rules::Binary

      def valid?
        is_valid = true
        [left, right].each do |rule|
          res = rule.valid?
          is_valid = res unless res
        end
        is_valid
      end

    end
  end
end
