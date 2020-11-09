require 'open-uri'

class GamesController < ApplicationController

  def new
    letters_array = ("a".."z").to_a
    grid = []
    10.times do
      grid << letters_array.sample
    end
    @letters = grid
  end

  def score
    # check if word is in dicionary
    letters = params[:letters]
    big_letters = letters.upcase
    @word = params[:userword]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    result = open(url).read
    words = JSON.parse(result)
    if words["found"]
      # check if word has only grid letters
      letters = @word.chars # returns array of word letters
      if letters.all? { |x| params[:letters].include?(x) == true }
        @score = "Congratulations! #{@word} is a valid English word!"
      else
        @score = "Sorry, but #{@word} can't be bild out of #{big_letters}"
      end
    else
      @score = "Sorry, but #{@word} does not seem to be a valid English word..."
    end
  end
end
