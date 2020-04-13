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

get '/mine' do
  last_block = blockchain.last_block
  test_solution = blockchain.mine_work(last_block)
  # reward reward for finding the solution.
  blockchain.new_transaction(
    sender= '0',
    receiver= Process.pid(),
    amount= 12.5 # reward for bitcoin miner
  )

  previous_hash = blockchain.hash(last_block)
  blockchain.new_block(test_solution,previous_hash)
  block = blockchain.last_block
  puts block
  response = {
    message: 'new block added to chain',
    index: block[:index],
    transactions: block[:transactions],
    test_solution: block[:proof],
    previous_hash: block[:previous_hash]
    }.to_json
end