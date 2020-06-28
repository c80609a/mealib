class Hash

  def camelcase_keys(type: :symbol, first: :lower)
    transform_keys &camelcase_proc(type: type, first: first)
  end


  def camelcase_keys!(type: :symbol, first: :lower)
    transform_keys! &camelcase_proc(type: type, first: first)
  end


  def deep_camelcase_keys(type: :symbol, first: :lower)
    deep_transform_keys &camelcase_proc(type: type, first: first)
  end


  def deep_camelcase_keys!(type: :symbol, first: :lower)
    deep_transform_keys! &camelcase_proc(type: type, first: first)
  end


  def underscore_keys!(symbol = false)
    transform_keys! &underscore_proc(symbol)
  end


  def underscore_keys(symbol = false)
    self.dup.underscore_keys(symbol)
  end


  def deep_underscore_keys!(symbol = false)
    deep_transform_keys! &underscore_proc(symbol)
  end


  def deep_underscore_keys(symbol = false)
    self.dup.deep_underscore_keys!(symbol)
  end


  private


  def camelcase_proc(type: :symbol, first: :lower)
    proc { |key| type == :symbol ? key.to_s.camelcase(first).to_sym : key.to_s.camelcase(first) }
  end


  def underscore_proc(symbol)
    proc { |key| new_key = key.to_s.underscore; symbol ? new_key.to_sym : new_key }
  end

end
