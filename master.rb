class Mastermind
  attr_accessor :code, :game_over, :clue, :guess_number

  def initialize
    @clue = []
    @code = []
    @game_over = false
    @guess_number = 0
    puts "How to play Mastermind:

This is a 1-player game against the computer.
There are six different number combinations:

  1     2     3     4     5     6   


The computer  will choose four to create a 'master code'. For example,

  1     3     4     1   

As you can see, there can be more then one of the same numbers.
In order to win, the code breaker needs to guess the 'master code' in 12 or less turns."

    puts "After each guess, there will be up to four clues to help crack the code.

X This clue means you have 1 correct number in the correct location.

* This clue means you have 1 correct number, but in the wrong location.

o This clue means one number was not anywhere in the code."
  end

  def end_game
    @game_over = true
  end

  def reset_guess
    @guess_number = 0
  end

  def guess_num
    @guess_number
  end

  def guess_counter
    @guess_number += 1
  end

  def show_clue
    @clue.reverse.join('-')
  end

  def clear_clue
    @clue = []
  end

  def position_true
    @clue.push('X')
  end

  def there_true
    @clue.push('*')
  end

  def fill_true
    @clue.push("o")
  end

  def create_code
    array = []
    4.times do
      array.push(rand(1..6).to_s)
    end
    self.code = array
  end

  def guess_check(guess)
    acceptable = true
    acceptable_answers = ['1', '2', '3', '4', '5', '6']
    guess_array = guess.split('')
    acceptable = false unless guess_array.length == 4
    guess_array.each do |i|
      acceptable = false unless acceptable_answers.any?(i) == true
    end
    if acceptable == true
      return true
    else
      return false
    end
  end

  def check_positions(guess_string)
    guess_array = guess_string.split('')
    incorrect_array = []
    guess_array.each_index do |i|
      if guess_array[i] == @code[i]
        self.position_true
      else
        incorrect_array.push(guess_array[i])
      end
    end
    incorrect_array
  end

  def check_there(guess_string)
    guess_array = guess_string.split('')
    @code.each { |i| self.there_true if guess_array.any?(i) || @code.length < 4}
  end

  def fill_clue
    self.fill_true until @clue.length == 4
  end

  def incorrect_guess(guess)
    if self.guess_num < 12
      self.check_positions(guess)
      self.check_there(guess)
      self.fill_clue
      puts "Incorrect. #{12 - self.guess_num} guesses left."
      puts "Clue: #{self.show_clue}"
    else
      puts 'Incorrect guess. No Guesses left. Game over'
    end
  end

  def answer_check
    guess = gets.strip
    self.clear_clue
    if guess == 'q'
      self.end_game
      puts 'Quitting Game...'
    elsif self.guess_check(guess) == false
      puts "Guess must be 4 digits long and use only numbers 1-6."
    elsif guess.to_s.split('') == self.code
      self.end_game
      puts 'You Guessed Correct!'
    else
      self.guess_counter
      self.incorrect_guess(guess)
    end
  end

  def game_loop
    self.answer_check while self.game_over == false && self.guess_num < 12
  end

  def play_game
    self.create_code
    puts self.code
    puts 'Enter your 4 digit code below:'
    self.game_loop
  end

  def play_again
    answered = false
    while answered == false
      puts 'Would you like to play Mastermind? (y/n)'
      answer = gets.strip
      if answer == "y" || answer == "Y"
        self.reset_guess
        self.play_game
      elsif answer == "n" || answer == "N"
        answered = true
        puts 'Thank you for playing!'
      else
        puts 'Please enter "y" for yes or "n" for no.'
      end
    end
  end
end
game = Mastermind.new
game.play_again

def check_positions(guess_string)
  guess_array = guess_string.split('')
  @code.each_index do |i|
    guess_array.each_index do |j|
      if i == j
        if guess_array.index(i) == @code.index(j)
          self.position_ture
        else
          self.there_true
        end
      end
    end
  end
end

