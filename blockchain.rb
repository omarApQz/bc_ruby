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

  def mine_work(last_block)
    test = 0
    puts last_block[:previous_hash]
    until self.valid_test(last_block[:previous_hash], test)
      test += 1
    end
    puts test
    test
  end

  def valid_test(last_hash, test)
    str = "#{last_hash}#{test}"
    dig = Digest::SHA256.hexdigest(str)
    dig[0..3] == '0'*4 # difficult problem
  end
end


# bc = Blockchain.new
# bc.mine_work('hola') # 85199
# bc.mine_work(bc.last_block)
