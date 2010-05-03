class Email < ActiveRecord::Base  
  has_many :relations, :dependent => :destroy
  has_many :email_addresses, :through => :relations
  
  def all_addresses
    (addresses("to") + addresses("cc") + addresses("from"))
  end

  def addresses(context)
    addresses = self.relations.find_all_by_context(context).collect { |r| r.email_address }.uniq
    
    addresses
  end
end
