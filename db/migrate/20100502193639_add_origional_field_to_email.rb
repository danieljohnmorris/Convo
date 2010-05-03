class AddOrigionalFieldToEmail < ActiveRecord::Migration
  def self.up
    change_table :emails do |t|
      t.text :origional
    end
  end

  def self.down
    change_table :emails do |t|
      t.remove :origional
    end
  end
end
