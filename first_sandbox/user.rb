class User
  require_relative "encrypt"

  # con este helper method puedo leer y escribir el atributo name de los objetos tipo User
  # este es para ambos, hay para solo leer y para solo escribir
  # si no lo tuvieramos la unica manera de acceder a esto es por medio de los metodos
  attr_accessor :name
  attr_reader :password, :user_name

  # initialize para "inicializar" con .new cuando queramos un objeto de esta clase
  # usr = User.new() -> al darle valores default podemos pasarle o no valores al nuevo objeto ya que tiene valores default
  # usr = User.new(name: 'Sergio', user_name: 'Otkl3y', password: 'passwordSecreto')
  def initialize(name: 'testName', user_name: 'test', password: '123456')
    @name = name
    @user_name = user_name
    @password = password
  end

  def encrypt_data
    puts "- Your encrypted user name is: #{@user_name} and your encrypted password is: #{@passowrd}"
  end

  # al cambiar el metodo a privado solo podemos acceder a ellos a traves de metodos publicos que los llamen...
  private def normal_data
    puts "- Your user name is: #{@user_name} and your password is: #{@passowrd}"
  end

  # se pondra un metodo publico aca pero normalmente los privados van juntos y no revueltos con los publicos
  # aqui llamamos un metodo privado desde un publico para proteger el metodo privado, como tal solo vemos el resultado
  def puts_normal_data_private_method
    normal_data
  end

  def real_encrypt(data)
    RealEncrypt.real_encrypt_data(data)
  end
end

# creamos un user pasandole valores
usr = User.new(name: 'Sergio', user_name: 'Otkl3y', password: 'passwordSecreto')
usr.puts_normal_data_private_method
usr.encrypt_data
puts usr.name
puts usr.password
usr.name = 'otroNombre'
puts "Aqui ya cambiamos el nombre del objeto a: #{usr.name}"

puts
puts '-----------------------------'
puts

# creamos un usear con los valores default del metodo
usr2 = User.new()
usr2.puts_normal_data_private_method
usr2.encrypt_data
puts "Nombre: #{usr2.name}"

puts
puts '-----------------------------'
puts

# agregamos complejidad agregando al inicio require_relative "encrypt"
# para comenzar con nuestro sandbox de encrypt data
encrypt = Encrypt.new(usr)
encrypt.puts_user
encrypt.encrypt_data(usr.name)
encrypt.encrypt_data(usr.password)
encrypt.encrypt_data(usr.user_name)

puts
puts '-----------------------------'
puts

usr.real_encrypt(usr.user_name)