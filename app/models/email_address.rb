class EmailAddress < ActiveRecord::Base
  has_many :relations, :dependent => :destroy
  has_many :emails, :through => :relations

  
  def messages(context)
    emails = self.relations.find_all_by_context(context).collect { |r| r.email }.uniq
    
    emails
  end
end
