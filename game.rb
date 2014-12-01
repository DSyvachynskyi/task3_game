module Codebreaker
  class Game
    def initialize
      @secret_code = ""
      @num = ""
      @msg = ""
    end
 
    def start
      @secret_code = "#{rand(1..6)}"+"#{rand(1..6)}"+"#{rand(1..6)}"+"#{rand(1..6)}"
	#puts @secret_code
    end

    def score(points)
	puts "Your score: #{points} points! \n Please enter your name: \n"
	name = gets.chomp.to_s
	file = File.open('./score/score', 'a')
	file.write("\n"+name+" "+"#{points}")
    end

    def game_progress
	puts "Enter four numbers between 1 and 6"	
	  i = 0	
	  j = 0
	  pts = 45
	  hint = ""
	  
	loop do
	  answer = ""
	  i += 1
	  pts -= 5
	  @num = gets.chomp.to_s
	if @num.size == 4
	  for j in 0..3	
		if @num[j] == @secret_code[j]
		answer << "+"
		end
		if @num[j] != @secret_code[j] 
			if @secret_code.include? @num[j]
			answer << "-"
			end
		
		end
	  end
	if hint == ""
		puts "Enter 'hint' to take a hint"
	  if @num == "hint"
		hint << @secret_code[rand(0..3)]
		puts "Your hint is: #{hint}"
	end	
	  end
	  puts answer
	  @msg = "Try again" if @num != @secret_code	 
	  @msg = "Congratulations!" if @num == @secret_code
	  @msg = "Game over" if i==8
	else
	  @msg = "Wrong number of arguments \nTry again"
		
	end
	puts @msg
	if i==8 
		if @num != @secret_code
		pts=0
		end
		end
	break if i==8
	break if @num == @secret_code
	end
	score(pts)
    end

    def self.play_again 
	loop do
	a = Codebreaker::Game.new
	a.start
	a.game_progress
	puts "Enter 'yes' if you want to play again"
	again = gets.chomp.to_s
		if again == "yes"
		redo
		else
		break
		end
	end
    end

  end
end

Codebreaker::Game.play_again

