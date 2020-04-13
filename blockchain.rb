require 'digest'
require 'time'

class Blockchain
  attr_accessor :chain, :current_transactions

  def initialize()
    @current_transactions = []
    @chain = []
    @last_block=@chain[-1]
    new_block(1,'1')#Bloque genesis
  end

  def last_block
    @chain[-1]
  end

  def new_block(proof, previous_hash)
    self.chain << {
      index: self.chain.length + 1,
      timestamp: Time.now.to_i,
      transactions: self.current_transactions,
      proof: proof,
      previous_hash:previous_hash
    }
    self.current_transactions = []
  end

  def hash(block)
    hash_block = Digest::SHA256.hexdigest(block.to_s)
    # puts hash_block
    hash_block
  end

  def new_transaction(sender, receiver, amount)
    puts "#{sender} -- #{receiver} -- #{amount}"
    self.current_transactions << {
      sender: sender,
      receiver: receiver,
      amount: amount
    }
    self.last_block[:index] + 1
  end
end


# bc = Blockchain.new
# # puts bc.chain
# puts bc.last_block
# last_hash = bc.hash(bc.last_block)
# bc.new_block(2,last_hash)
# last_hash = bc.hash(bc.last_block)
# bc.new_block(8,last_hash)
# puts bc.chain