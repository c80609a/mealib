module Dry
  class Errors

    attr_reader :messages

    def initialize(messages = {})
      @messages = messages
    end


    def add(key, message)
      keys = key.to_s.split('.').map!(&:to_sym)
      old  = messages.dig(*keys[0...-1]) rescue {}
      old  = {} unless old.is_a?(Hash)
      new  = keys[0...-1].inject(messages) { |h, k| h[k] ||= {} rescue h = {}; h[k] = {} }
      new[keys.last] = [] unless new.is_a?(Array)
      new[keys.last] << message
      new.merge!(old)
    end


    def merge!(error, parent_key = nil)
      hash_to_dots(error.messages, {}, parent_key).each do |key, messages|
        messages.each { |message| add(key, message) }
      end
      messages
    end


    def any?
      messages.any?
    end


    def has_key?(key)
      keys = key.to_s.split('.').map!(&:to_sym)
      keys.size == 1 ? messages[keys.first].present? : (messages.dig(*keys[0...-1])[keys.last].present? rescue false)
    end


    def first_message
      fetch_messages(messages.values.first).first
    end


    def clone
      self.class.new(messages.clone)
    end


    private


    def hash_to_dots(hash, results = {}, start_key = '')
      hash.each do |key, value|
        key = key.to_s
        key_value = start_key.present? ? sprintf('%s.%s', start_key, key) : key
        if value.is_a?(Hash)
          results.merge!(hash_to_dots(value, results, key_value))
        else
          results[key_value] = value
        end
      end
      results
    end


    def fetch_messages(value)
      if value.is_a?(Hash)
        fetch_messages(value.values.first)
      else
        value
      end
    end

  end
end
