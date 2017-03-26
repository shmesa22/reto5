=begin
1. Hacer pregunta al usuario
2. Pedir respuesta del usuario	
3. Determinar si la respuesta es correcta o incorrecta
		Si la respuesta es correcta volver al punto 1.
		Si la respuesta es incorrecta volver al punto 2.
4. Despues de 5 preguntas correctas fin del juego
=end

class Country
	attr_reader :countries, :country

	def initialize
		@countries = ["Colombia", "Venezuela", "Argentina", "Brasil", "Uruguay", "Bolivia", "Chile", "Ecuador",
		 "Guyana", "Paraguay", "Peru", "Suriname"]
		$country = ""
		@countries.shuffle!
	end

	def get_country
		@country = @countries.shift
	end

end

class Answer
	attr_reader :answers, :country, :question, :correct_answer, :user_answer

	def initialize(country)
		@answers = {
			"Colombia" => "bogotá", 
			"Venezuela" => "caracas", 
			"Argentina" => "buenos aires", 
			"Brasil" => "brasilia", 
			"Uruguay" => "montevideo",
			"Bolivia" => "la paz",
			"Chile" => "santiago",
			"Ecuador" => "quito",
			"Guyana" => "georgetown",
			"Paraguay" => "asunción",
			"Peru" => "lima",
			"Suriname" => "paramaribo"
		}
		@country = country
		@question = ""
		@correct_answer = ""
		$user_answer = ""
	end

	def get_question
		@question = @country.get_country
	end

	def get_answer
		@correct_answer = @answers[@question]
	end 

	def check?
		@correct_answer == $user_answer
	end
end

question = Country.new
answer = Answer.new(question)

print "¿Cuál es tu nombre? "
user = gets.chomp

puts """
Bienvenido #{user} al Reto '5 capitales de América'. En este reto te 
preguntaremos, aleatoriamente, por las capitales de 5 países de 
Suramérica.

"""

print "¿Estás listo para empezar el Reto (Y/N)? "
ready = gets.chomp.downcase
puts

if ready == "y"
	count = 1
	while count <= 5
		puts "¿Cuál es la capital de #{answer.get_question}?"

		check = true
		while check	
			print "Respuesta: "
			$user_answer = gets.chomp.downcase
			answer.get_answer
			if answer.check?
				puts
				puts "Correcto!"
				puts "#{count}/5"
				puts
				count += 1
				check = false
			else
				puts
				puts "Intenta de nuevo"
				puts
			end
		end
	end

	puts "Felicidades #{user},"
	puts "Has completado el Reto '5 capitales de America'!"
end