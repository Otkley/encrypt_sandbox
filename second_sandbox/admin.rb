class Admin
  # dentro del irb -> require "./admin.rb"
  # si quiero recargarlo sin salir -> load "./admin.rb"
 
  # require_relative: Instrucción para cargar un archivo Ruby relativo al archivo actual
  require_relative "academy"

  attr_accessor :name, :last_name
  attr_reader :user_name, :email, :phone, :academies

  def initialize(name, last_name, user_name, email, phone, password, academies = [])
    @name = name.capitalize
    @last_name = last_name.capitalize
    @user_name = user_name.downcase
    @email = email.downcase
    @phone = phone
    @password = password
    @academies = academies

    welcome
  end

  def menu
    puts "-----------------------"
    puts "Menu:"
    puts "0.- Salir"
    puts "1.- Mostrar academias"
    puts "2.- Agregar academia"
    puts "3.- Editar academia"
    puts "4.- Eliminar academia"

    # gets: obtiene la entrada del usuario como String pero con salto de linea al final \n
    # chomp: elimina el \n del final
    # gets.chomp
    opcion = gets.chomp

    case opcion
    when "0"
      puts "¡Hasta pronto!"
    when "1"
      show_academies
      menu
    when "2"
      create_academy
      menu
    when "3"
      menu
    when "4"
      menu
    else
      puts "Esa no es una opción valida..."

      menu
    end
  end

  private

  # mostramos las academias si es que tiene
  def show_academies
    if(@academies.length > 0)
      puts "Tus academias registradas son:"

      @academies.each do |academy|
        puts academy.name
      end
    else
      puts "No cuentas con ninguna academia registrada"
    end
  end

  # creamos academias para el admin
  def create_academy
    puts "Vamos a crear una nueva academia"

    print "Nombre: "
    academy_name = gets.chomp

    if @academies.length > 0
      @academies.each do |academy|
        if academy.name.downcase == academy_name.downcase
          puts "No fue posible crear la academia, intenta nuevamente"
        
          menu
        end
      end
    end

    print "Logo: "
    logo = gets.chomp

    set_academy(academy_name, logo)
  end

  def set_academy(name, logo)
    academy = Academy.new(name, logo)

    if academy
      @academies << academy

      puts "#{academy.name} fue creada correctamente"
    else
      puts "No fue posible crear la academia, hubo un error"
    end
  end

  def welcome
    puts "¡Haz creado tu cuenta con exito!"
    puts "Bienvenido #{@name} #{@last_name}"
    puts "Usa el metodo menu para ver todas las opciones disponibles"
  end
end
