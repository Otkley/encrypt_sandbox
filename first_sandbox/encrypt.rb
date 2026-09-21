class Encrypt

  def initialize(user)
    @user = user
  end

  def puts_user
    puts "Mensaje desde encrypt, recibi el user: #{@user.name}"
  end

  def encrypt_data(data)
    puts "Data encriptada: #{data}"
  end
end

class RealEncrypt
  # No necesitas Bundler para este ejercicio
  # openssl y base64 forman parte de la biblioteca estándar/stdlib de Ruby.
  require "openssl"
  require "base64"

  # si no quieres inicializar una clase para usar su metodo
  # usamos self. al inicio asi podemos llamar el metodo
  # teniendo la clase al alcance sin inicializar nada
  def self.real_encrypt_data(data)
    clave = OpenSSL::Random.random_bytes(32)
    iv = OpenSSL::Random.random_bytes(12)

    cipher = OpenSSL::Cipher.new("aes-256-gcm")
    cipher.encrypt

    cipher.key = clave
    cipher.iv = iv

    cifrado = cipher.update(data) + cipher.final
    tag = cipher.auth_tag

    puts "Original: #{data}"
    puts "Cifrado:  #{Base64.strict_encode64(cifrado)}"
    puts "Tag:      #{Base64.strict_encode64(tag)}"
  end
end
