class RemoveAddressFieldsFromEmails < ActiveRecord::Migration
  def self.up
    change_table :emails do |t|
      t.remove   "to"
      t.remove   "cc"
      t.remove   "bcc"
      t.remove   "from"
    end
  end

  def self.down
    change_table :emails do |t|
      t.string   "to"
      t.string   "cc"
      t.string   "bcc"
      t.string   "from"
    end
  end
end

