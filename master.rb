class Mastermind
  attr_accessor :code, :game_over
  def initialize
    @code = Array.new
    @game_over = false
    puts "Welcome to Mastermind. The game is played...."
  end

  def create_code
    array = []
    4.times do
      array.push(rand(1..6).to_s)
    end
    self.code = array
  end

  def play_game
    self.create_code
    puts self.code
    puts "Enter your 4 digit code below:"
    while self.game_over == false
      guess = gets.strip
      if guess == "q"
        self.game_over=true
        puts "Game Over"
      elsif guess.to_s.split("") == self.code
        self.game_over=true
        puts "You Guessed Correct!"
      else
        puts "Incorrect. Guess again."
      end
    end
  end
end

game = Mastermind.new
game.play_game
