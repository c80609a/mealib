class AbstractSerializer

  # extend ActionView::Helpers::NumberHelper
  # extend ApplicationHelper

  class << self

    def serialize(model, attributes: available_attributes, opts: {})
      @opts = opts
      unknown_attributes = attributes - available_attributes

      if unknown_attributes.present?
        raise StandardError, sprintf('Unknown attributes: %s', unknown_attributes.join(', '))
      end

      attributes.each_with_object({}) { |attribute, result| result.merge!(send(attribute, model)) }
    end

    def available_attributes
      []
    end

    def opts
      @opts
    end

  end
end
