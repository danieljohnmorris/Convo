class CreateEmailAddresses < ActiveRecord::Migration
  def self.up
    create_table :email_addresses do |t|
      t.string :name
      t.string :address

      t.timestamps
    end

    create_table :emails_email_addresses, :id => false do |t|
      t.references :email, :email_address
    end
  end

  def self.down
    drop_table :email_addresses
    drop_table :emails_email_addresses
  end
end
