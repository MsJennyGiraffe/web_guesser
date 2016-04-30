require 'sinatra'
require 'sinatra/reloader'
require 'erb'

@@number = rand(101)
@@number_of_guesses = 5

get '/' do
  if params[:guess].nil?
    guess = ""
    answer = "Please enter a guess"
    guesses = ""
    @@color = "white"
  elsif params[:guess] == ""
      guess = ""
      answer = "ENTER A NUMBER, you goof."
      guesses = ""
      @@color = "purple"
  else
    guess = params[:guess].to_i
    cheat = cheat_mode(params[:cheat])
    answer = guess_checker(guess)
    guesses = guess_tracker
  end
  erb :index, locals: {
    number:        @@number,
    answer:        answer,
    color:         @@color,
    guess_tracker: guesses,
    cheat:         cheat
  }
end

def guess_checker(guess)
  if guess > @@number + 5
    @@color = "red"
    "WAY TOO HIGH!"
  elsif guess > @@number
    @@color = "pink"
    "You're getting very warm, but still too hiiiigh."
  elsif guess < @@number - 5
    @@color = "red"
    "WAY TOO LOW!"
  elsif guess < @@number
    @@color = "pink"
    "You're getting very warm, but still too low"
  else
    @@color = "green"
    "YESS! You did it! Good job, buddy. The secret number was #{@@number}!"
  end
end

def guess_tracker
  @@number_of_guesses -= 1
  if @@number_of_guesses == 0
    @@number_of_guesses = 5
    @@number = rand(101)
    "You are out of guesses, Homie. Play again?"
  else
    "You have #{@@number_of_guesses} left."
  end
end

def cheat_mode(cheat)
  cheat ? "The secret number is #{@@number}" : ""
end
