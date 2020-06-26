module Dry
  class Rule

    attr_reader :value, :errors, :args

    def initialize(value, errors = Dry::Errors.new, **args)
      @value  = value
      @errors = errors
      @args   = args.symbolize_keys
    end


    def name
      args[:name]
    end


    def add_error
      errors.add(key, messages[name.to_s] || 'invalid')
    end


    def clone
      self.class.new(value, errors.clone, args)
    end


    def and(right)
      Dry::Rules::And.new(self, errors, args.merge(right: right))
    end
    alias :& :and


    def then(right)
      Dry::Rules::Then.new(self, errors, args.merge(right: right))
    end
    alias :> :then


    def or(right)
      Dry::Rules::Or.new(self, errors, args.merge(right: right))
    end
    alias :| :or


    def +(right)
      Dry::Rules::Collection.new(self, errors, args.merge(right: right))
    end


    def valid?
      raise NotImplementedError
    end


    private


    def messages
      @messages ||= (args[:messages] || {}).deep_stringify_keys
    end


    def key
      @key ||= args[:key] || (raise 'Missing required param "key"')
    end

  end
end
