# NOTE this class should rise the errors since most of them are related with missconfiguration
# or missing parameters
class ManageJWT
  include Singleton

  # @returns [Array] with payload and header
  def decode(new_token:)
    JWT.decode(new_token, verify_key, true, { algorithm: algorithm } )
  end

  # @returns [String] with the created token
  def encode(user_id:)
    JWT.encode({user_id: user_id}, signing_key, algorithm, header)
  end

  private

  def algorithm
    'RS256'.freeze
  end

  def header
    {
      exp: Time.now.to_i + 20 #expire in 20 seconds
    }
  end

  def signing_key
    @signing_key ||= read_key(signing_key_path)
  end

  def verify_key
    @signing_key ||= read_key(signing_key_path)
  end

  def signing_key_path
    @signing_key_path ||= load_file("../../../config/#{ENV["RSA_NAME"]}")
  end

  def verify_key_path
    @verify_key_path ||= load_file("../../../config/#{ENV["RSA_NAME"]}.pub")
  end

  def load_file(path)
    File.expand_path(path, __FILE__)
  end

  def read_key(path)
    file = File.read(path)
    OpenSSL::PKey.read(file)
  end

end
