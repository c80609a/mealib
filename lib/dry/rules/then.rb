module Dry
  module Rules
    class Then < Dry::Rules::Composite

      def valid?
        return true if (!lt.valid? || rt.valid?)
        errors.merge!(rt.errors)
        false
      end

    end
  end
end
