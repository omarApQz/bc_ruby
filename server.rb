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

post '/transactions/new' do
  body = JSON.parse(request.body.read)
  indexBlock = blockchain.new_transaction(body['sender'], body['receiver'], body['amount'])
  response = {msg:"La transacción se agrego al block #{indexBlock}"}
  response.to_json
end