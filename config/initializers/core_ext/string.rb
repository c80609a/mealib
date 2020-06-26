class String

  def clear_query
    dup.clear_query!
  end

  def clear_query!
    gsub!(/\s+/, ' ')
    strip!
    self
  end

  def nums_only
    scan(/\d/).join
  end

  def numeric?
    true if Float(self) rescue false
  end

  def to_bool
    %w[t true yes on 1].include? self
  end

  # def sanitize(options = {})
  #   ActionController::Base.helpers.sanitize(self, options)
  # end

  def nl2br
    dup.nl2br!
  end

  def nl2br!
    gsub!(/\r/, '')
    gsub!(/\n/, '<br>')
    self
  end

  def strip_leading_zeros
    dup.strip_leading_zeros!
  end

  def strip_leading_zeros!
    gsub!(/^0+/, '')
    self
  end

  def try_to_integer
    Integer( try_to_big_decimal ) rescue self
  end

  def try_to_big_decimal
    gsub!(/\s/, '')
    begin
      Float(self)
    rescue
      return self
    end
    BigDecimal(self)
  end

end
