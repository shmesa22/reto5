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

# vistas del reto
class Views
  def get_user
    print "¿Cuál es tu nombre? "
  end

  def welcome(user)
    puts """
    Bienvenido #{user} al Reto '5 capitales de América'. En este reto te 
    preguntaremos, aleatoriamente, por la capitales de 5 países de 
    Suramérica.
    ¡Empecemos!

    """
  end

  def ask_question(question)
    puts "¿Cuál es la capital de #{question}?"
  end

  def answer
    print "Respuesta: "
  end

  def right_answer(count)
    puts
    puts "Correcto!"
    puts "#{count}/5"
    puts
  end

  def wrong_answer
    puts
    puts "Intenta de nuevo"
    puts
  end

  def win_challenge(user)
    puts "Felicidades #{user},"
    puts "Has completado el Reto '5 capitales de America'!"
  end
end

# logica del reto
class Challenge
  attr_reader :user, :answer, :user_answer, :views, :count, :check

  def initialize(answer, views)
    @user = ""
    @answer = answer
    @user_answer = ""
    @views = views
    @count = 1
    @check
  end

  def check?
    @answer.get_answer == @user_answer
  end

  def run
    @views.get_user
    @user = gets.chomp  
    @views.welcome(@user)
    while @count <= 5
      @views.ask_question(@answer.get_question)

      @check = true
      while @check 
        @views.answer
        @user_answer = gets.chomp.downcase
        if self.check?
          @views.right_answer(@count)
          @count += 1
          @check = false
        else
          @views.wrong_answer
        end
      end
    end
    @views.win_challenge(@user)  
  end
end

country = Country.new
capital = Answer.new(country)
views = Views.new
game = Challenge.new(capital, views)

game.run
