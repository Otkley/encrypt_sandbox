class Academy
  attr_accessor :logo
  attr_reader :name

  def initialize(name, logo = '')
    @name = name
    @logo = logo
  end
end
