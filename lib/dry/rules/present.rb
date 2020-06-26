module Dry
  module Rules
    class Present < Dry::Rule

      def valid?
        return true if value.present?
        add_error
        false
      end


      private


      def name
        'present'
      end

    end
  end
end
