class AddMultipartBodyToEmails < ActiveRecord::Migration
  def self.up
    change_table :emails do |t|
      t.text :body_plain
      t.text :body_html
      
      t.remove :body
    end
  end

  def self.down
    change_table :emails do |t|
      t.text :body
      
      t.remove :body_plain
      t.remove :body_html
    end
  end
end
