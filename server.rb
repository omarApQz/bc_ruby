require 'sinatra'

set :port, ARGV[0]

get '/' do
  'Welcome to Ruby with sinatra!'
end
