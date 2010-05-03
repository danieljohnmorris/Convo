class CreateRelationshipJoinTable < ActiveRecord::Migration
  def self.up
    create_table :relations do |t|
      t.references :email, :email_address
      t.string :context
    end

    drop_table :emails_email_addresses
  end

  def self.down
    create_table :emails_email_addresses, :id => false do |t|
      t.references :email, :email_address
    end
    
    drop_table :relations
  end
end
