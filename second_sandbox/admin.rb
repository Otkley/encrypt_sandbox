class Admin
  require "debug" # binding.break

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
    loop do
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
      opcion = gets.chomp.strip

      case opcion
      when "0"
        puts "¡Hasta pronto!"

        break
      when "1"
        if(@academies.length > 0)
          puts "Tus academias registradas son:"
          show_academies
        else
          puts "No cuentas con ninguna academia registrada"
        end
      when "2"
        create_academy
      when "3"
        if @academies.length > 0
          edit_academy
        else 
          puts "No tienes academias para editar"
        end
      when "4"
        if @academies.length > 0
          delete_academy
        else
          puts "No tienes academias para eliminar"
        end
      else
        puts "Esa no es una opción valida..."
      end
    end
  end

  private

  def welcome
    puts "¡Haz creado tu cuenta con exito!"
    puts "Bienvenido #{@name} #{@last_name}"
    puts "Usa el metodo menu para ver todas las opciones disponibles"
  end

  # mostramos las academias si es que tiene
  def show_academies
    @academies.each do |academy|
      puts academy.name
    end
  end

  # creamos academias para el admin
  def create_academy
    puts "Vamos a crear una nueva academia"

    print "Nombre: "
    academy_name = gets.chomp.strip

    if academy_name.empty?
      puts "No pueden existir academias sin nombre"

      return
    end

    if @academies.length > 0
      @academies.each do |academy|
        if academy.name.downcase == academy_name.downcase
          puts "No fue posible crear la academia, intenta nuevamente"
        end
      end
    end

    print "Logo: "
    logo = gets.chomp.strip

    init_valid_academy(academy_name, logo)
  end

  def init_valid_academy(name, logo)
    academy = Academy.new(name, logo)

    if academy
      @academies << academy

      puts "#{academy.name} fue creada correctamente"
    else
      puts "No fue posible crear la academia, hubo un error"
    end
  end

  def edit_academy
    show_academies
    
    print "¿Que academia deseas editar?: "
    academy_name = gets.chomp.strip

    academy = set_academy(academy_name)
    if academy

      puts academy.name
      puts academy.logo
  
      puts "Presiona enter para conservar el valor actual"
      print "Nuevo nombre: "
      new_name = gets.chomp.strip
      if !new_name.empty?
        academy.name = new_name
      end
  
      print "Nuevo logo: "
      new_logo = gets.chomp.strip
      if !new_logo.empty?
        academy.logo = new_logo
      end
  
      puts "Tu academia a sido editada correctamente"
      puts "#{academy.name} - #{academy.logo}"
    else
      puts "No existe academia con ese nombre para editar"
    end
  end

  def delete_academy
    show_academies
    
    print "¿Que academia deseas eliminar?: "
    academy_name = gets.chomp.strip

    academy = set_academy(academy_name)
    if academy
      puts "y / n"
      puts "Seguro que deseas eliminar tu academia: #{academy.name}"

      response = gets.chomp.downcase.strip

      if response == 'y'
        @academies.delete(academy)

        puts "Tu academia #{academy.name} fue eliminada correctamente"
      elsif response == 'n'
        puts "No se eliminara ninguna academia"
      else
        puts "No es una opcion correcta"
      end
    else
      puts "No existe ninguna academia con ese nombre"
    end
  end

  def set_academy(name)
    if @academies.length > 0
      @academies.each do |academy|
        return academy if academy.name.downcase == name.downcase
      end

      nil
    end
  end
end
