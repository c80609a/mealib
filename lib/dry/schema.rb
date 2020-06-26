module Dry
  module Schema

    attr_reader :attributes, :errors

    def initialize(params)
      @errors     = Dry::Errors.new
      @attributes = cast({ wrap: params }.deep_symbolize_keys[:wrap], schema)
      JSON::Validator.validate!(schema, attributes)
    end


    def [](key)
      attributes[key.to_sym]
    end


    def valid?
      validate_attributes(attributes, schema)
      validate_additional
      !errors.any?
    end


    def schema
      raise NotImplemented
    end


    private


    def validate_additional
    end


    def validate_attributes(props, schema, parents = [], key = nil)
      case props
        when Dry::Schema
          errors.merge!(props.errors, (parents + [key]).compact.join('.')) unless props.valid?
        else
          [schema[:rule]].flatten.compact.each do |rule|
            rule = rule.arity == 0 ? rule(key, parents, &rule) : rule.call(parents)
            rule.valid? if rule
          end
      end

      if schema[:properties]
        (schema[:properties] || {}).each do |_key, data|
          validate_attributes((props.present? ? props : {})[_key.to_sym], data, (parents + [key]).compact, _key)
        end
      elsif schema[:items]
        (props.present? ? props : []).each_with_index do |e, i|
          validate_attributes(e, schema[:items], (parents + [key]).compact, i)
        end
      end

      if schema[:oneOf] || schema[:allOf] || schema[:anyOf]
        [:oneOf, :allOf, :anyOf].each do |k|
          s = schema[k]
          case s
            when Hash
              validate_attributes(props, s, parents, key)
            when Array
              s.each { |_s| validate_attributes(props, _s, parents, key) if _s.is_a?(Hash) }
            else
          end
        end
      end
    end


    def cast(params, schema)
      props = schema.is_a?(Hash) && schema[:cast] ? schema[:cast].call(params) : params

      case props
        when Hash
          props.each_with_object({}) do |(key, value), result|
            result[key] = find_schemas_for_attribute(key, schema).inject((value.dup rescue value)) do
              |_value, _schema| _value = cast(_value, _schema); _value
            end
          end
        when Array
          props.map { |e| cast(e, (schema[:items] rescue nil)) }
        else
          props
      end
    end


    def rule(attrs, parents, messages = {}, name = nil, &block)
      if block.arity == 0
        _attrs = [attrs].flatten.compact
        raise 'Invalid rule' if _attrs.size > 1
        single_rule(parents + _attrs, messages, &block)
      else
        multi_rule(attrs, parents, messages, name, &block)
      end
    end


    def single_rule(keys, messages = {}, &block)
      value   = attributes.dig(*keys) rescue nil
      factory = Dry::RulesFactory.new(value, errors, key: keys.join('.'), messages: messages)
      factory.instance_exec &block
    end


    def multi_rule(keys, parents, messages = {}, name = nil, &block)
      _keys = [keys].flatten.compact
      data  = parents.present? ? attributes.dig(*parents) : attributes

      data = _keys.inject({}) do |res, key|
        res[key.to_sym] = data[key.to_sym] rescue nil; res
      end

      factories = data.map do |key, value|
        _key = name || key
        _key = (parents + [_key]).join('.')
        Dry::RulesFactory.new(value, errors, key: _key, messages: messages)
      end

      block.call *factories
    end


    def find_schemas_for_attribute(key, schema, schemas = [])
      case schema
        when Hash
          s = schema[:properties][key] rescue nil
          schemas << s if s
          [:allOf, :anyOf, :oneOf].each { |k| find_schemas_for_attribute(key, schema[k], schemas) }
        when Array
          schema.each { |s| find_schemas_for_attribute(key, s, schemas) }
        else
      end


      schemas
    end


    def method_missing(method)
      attributes[method.to_sym]
    end

  end
end
