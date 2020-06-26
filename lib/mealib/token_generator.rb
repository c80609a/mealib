module TokenGenerator
  module_function

  def generate_token
    Digest::SHA2.hexdigest(Time.now.to_f.to_s + SecureRandom.urlsafe_base64(32))
  end
end
