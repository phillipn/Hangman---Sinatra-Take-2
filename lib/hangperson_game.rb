class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess(letter)
    raise ArgumentError.new("Letter cannot be blank") if letter !~ /\S/
    raise ArgumentError.new("Letter needs to be a letter") if letter !~ /[a-zA-Z]/
    letter.downcase!
    
    if @word.include?(letter)
      if @guesses.include?(letter) 
        return false
      else
        @guesses << letter
      end 
    elsif @wrong_guesses.include?(letter)
        return false
    else
        @wrong_guesses << letter
    end
  end
  
  def word_with_guesses
    @revealed = ''
    
    @word.split(//).each do |i|
      if @guesses.include?(i)
        @revealed += i
      else
        @revealed += '-'
      end
    end
    return @revealed
  end
  
  def check_win_or_lose
    if self.word_with_guesses == @word
      :win
    elsif @wrong_guesses.length == 7
      :lose
    else
      :play
    end
  end
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
