require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = (0...10).map { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    attempt = params[:answer]
    grid = params[:grid]
    @result = ""

    attempt_array = attempt.upcase.chars

    if attempt_array.all? { |letter| grid.include?(letter) } #&& grid.delete_at(grid.index(letter))
      url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
      response_serialized = open(url).read
      response = JSON.parse(response_serialized)

      if response["found"]
        @result = "Well Done!"
      else
        @result = "Word not an english word"
      end
    else
    @result = "Letters not in the grid"
    end

  end

end
