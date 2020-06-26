module Dry
  module Rules
    class Or < Dry::Rules::Composite

      def valid?
        return true if lt.valid? || rt.valid?
        [lt.errors, rt.errors].each { |e| errors.merge!(e) if e.any? }
        false
      end

    end
  end
end
