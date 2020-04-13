require 'sinatra'
require 'sinatra/reloader'
require 'json'
require './Blockchain'

set :port, ARGV[0]

before do
  content_type :json
end

blockchain = Blockchain.new
puts "Bloque genesis: #{blockchain.chain}"

get '/' do
  'Welcome to Ruby with sinatra!'
end

get '/chain' do
 	response = blockchain.chain
 	response.to_json
end