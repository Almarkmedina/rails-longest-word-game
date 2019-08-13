require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
    # @letters = Array.new(grid_size) { ('A'..'Z').to_a.sample }
  end

  def score
    # @letters = ('A'..'Z').to_a.sample(10)
    @word = params[:word]
    @letters = params[:letters]

    if (included?(@word, @letters)) && (check(@word))
      @answer = "Congratulations! #{@word} is a valid English word "
    elsif !check(@word)
      @answer = "Sorry but #{@word} does not seem to be a valid English word"
    else
      @answer = "Sorry but #{@word} can't be built out of #{@letters}"

    end
  end

# check word in dictionary api
  def check(word)
    english_word = open("https://wagon-dictionary.herokuapp.com/#{word}").read
    result = JSON.parse(english_word)
    result['found']
  end
 # only checks for letter frequencies
  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

end

  # def score
  #   @word = params[:word]
  #   english_word = open("https://wagon-dictionary.herokuapp.com/#{@word}")
  #   if @word == @letters
  #     @answer = "Sorry but #{@word} can't be built out of #{@letters}"
  #   elsif @word != english_word
  #     @answer = "Sorry but #{@word} does not seem to be a valid English word"
  #   else
  #     @answer = "Congratulations! #{@word} is a valid English word "
  #   end
  # end
