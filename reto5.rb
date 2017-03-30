=begin
1. Hacer pregunta al usuario
2. Pedir respuesta del usuario  
3. Determinar si la respuesta es correcta o incorrecta
    Si la respuesta es correcta volver al punto 1.
    Si la respuesta es incorrecta volver al punto 2.
4. Despues de 5 preguntas correctas fin del juego
=end

# define arreglo de países
class Country
  attr_reader :coutnries

  def initialize
    @f = File.open("preguntas.txt")
    @countries = []
    @country = ""
    get_countries
  end
  
  def get_country
    @country = @countries.shift
  end

  private
    def get_countries
      @f.each_line do |l|
        q = l.split(",")
        @countries << q[0]
      end
      @countries.shuffle!
    end 
end

# define la respuesta correcta
class Answer
  attr_reader :answers, :country, :question, :correct_answer, :user_answer

  def initialize(country)
    @f = File.open("preguntas.txt")
    @answers = {}
    @country = country
    @question = ""
    @answer = ""
    get_capitals
  end

  def get_question
    @question = @country.get_country
  end

  def get_answer
    @answer = @answers[@question]
  end

  private
    def get_capitals
      @f.each_line do |l|
        q = l.split(",")
        @answers[q[0]] = q[1].chomp
      end
    end
end

# logica del reto
class Challenge
  attr_reader :user, :answer, :user_answer, :count, :check

  def initialize(answer)
    @user = ""
    @answer = answer
    @user_answer = ""
    @count = 1
    @check
  end

  def get_user
    print "¿Cuál es tu nombre? "
    @user = gets.chomp
  end

  def welcome
    puts """
    Bienvenido #{user} al Reto '5 capitales de América'. En este reto te 
    preguntaremos, aleatoriamente, por la capitales de 5 países de 
    Suramérica.
    ¡Empecemos!

    """
  end

  def ask_question
    puts "¿Cuál es la capital de #{@answer.get_question}?"
  end

  def check?
    @answer.get_answer == @user_answer
  end

  def right_answer
    puts
    puts "Correcto!"
    puts "#{count}/5"
    puts
    @count += 1
    @check = false
  end

  def wrong_answer
    puts
    puts "Intenta de nuevo"
    puts
  end

  def win_challenge
    puts "Felicidades #{user},"
    puts "Has completado el Reto '5 capitales de America'!"
  end

  def run
    self.get_user  
    self.welcome
    while @count <= 5
      self.ask_question

      @check = true
      while @check 
        print "Respuesta: "
        @user_answer = gets.chomp.downcase
        if self.check?
          self.right_answer
        else
          self.wrong_answer
        end
      end
    end
    self.win_challenge  
  end
end

country = Country.new
capital = Answer.new(country)
game = Challenge.new(capital)

game.run
