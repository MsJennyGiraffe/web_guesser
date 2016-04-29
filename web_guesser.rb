require 'sinatra'
require 'sinatra/reloader'
require 'erb'

number = rand(101)

get '/' do
  erb :index, :locals => { :number => number}
end
