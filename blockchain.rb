require 'digest'
require 'time'

class Blockchain
  attr_accessor :chain, :current_transactions, :nodes

  def initialize()
    @current_transactions = []
    @chain = []
    @last_block=@chain[-1]
    @nodes=[]
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

  def register_node(node)
    self.nodes << node
    self.chain
  end

  def valid_chain(current_chain)
    block_check = current_chain[0]
    index = 1
    response = true
    while index < current_chain.size
      current_block = current_chain[index]
      last_block_hash = self.hash(block_check)
      if (current_block[:previous_hash] != last_block_hash) && self.valid_test(last_block_hash, current_block[:proof])
        response = false
      end
      index += 1
      block_check = current_block
    end
    response
  end
end


# bc = Blockchain.new
# bc.mine_work('hola') # 85199
# bc.mine_work(bc.last_block)
