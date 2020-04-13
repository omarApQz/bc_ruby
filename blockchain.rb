require 'digest'
require 'time'

class Blockchain
  attr_accessor :chain, :current_transactions

  def initialize()
    @current_transactions = []
    @chain = []
    new_block(1,1)#Bloque genesis
  end

  def new_block(proof, previous_hash)
    self.chain << {
      index: self.chain.length + 1,
      timestamp: Time.now.to_i,
      transactions: self.current_transactions,
      proof: proof,
      previous_hash: previous_hash
    }
    self.current_transactions = []
  end
end