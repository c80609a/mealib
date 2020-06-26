module Dry
  class RulesFactory

    attr_reader :value, :errors, :args

    def initialize(value, errors = Dry::Errors.new, **args)
      @value  = value
      @errors = errors
      @args   = args.symbolize_keys
    end


    def present?
      Dry::Rules::Present.new(value, errors, args)
    end


    def equal?(right)
      Dry::Rules::Equal.new(value, errors, build_args(right))
    end
    alias :eq? :equal?


    def not_equal?(right)
      Dry::Rules::NotEqual.new(value, errors, build_args(right))
    end
    alias :not_eq? :not_equal?


    def greater_than?(right)
      Dry::Rules::GreaterThan.new(value, errors, build_args(right))
    end
    alias :gt? :greater_than?


    def greater_than_or_equal?(right)
      Dry::Rules::GreaterThanOrEqual.new(value, errors, build_args(right))
    end
    alias :gt_eq? :greater_than_or_equal?


    def less_than?(right)
      Dry::Rules::LessThan.new(value, errors, build_args(right))
    end
    alias :lt? :less_than?


    def less_than_or_equal?(right)
      Dry::Rules::LessThanOrEqual.new(value, errors, build_args(right))
    end
    alias :lt_eq? :less_than_or_equal?


    def included?(right)
      Dry::Rules::Included.new(value, errors, build_args(right))
    end


    def length_equal?(right)
      Dry::Rules::LengthEqual.new(value, errors, build_args(right))
    end


    def min_length?(right)
      Dry::Rules::MinLength.new(value, errors, build_args(right))
    end


    def max_length?(right)
      Dry::Rules::MaxLength.new(value, errors, build_args(right))
    end


    def between?(right)
      Dry::Rules::Between.new(value, errors, build_args(right))
    end


    def length_between?(right)
      Dry::Rules::LengthBetween.new(value, errors, build_args(right))
    end


    def format?(right)
      Dry::Rules::Format.new(value, errors, build_args(right))
    end


    def each(&block)
      return if value.blank?
      value.inject(nil) do |rule, e|
        _rule = self.class.new(e, errors, args).instance_exec(&block)
        rule = rule ? rule & _rule : _rule
        rule
      end
    end


    def each_value(&block)
      return if value.blank?
      value.inject(nil) do |rule, (k, v)|
        _rule = self.class.new(v, errors, args).instance_exec(&block)
        rule = rule ? rule & _rule : _rule
        rule
      end
    end


    private


    def build_args(right)
      rt = right.is_a?(self.class) ? right.value : right
      args.merge(right: rt)
    end

  end
end
