class AddExtraFieldsToEmail < ActiveRecord::Migration
  def self.up
    change_table :emails do |t|
      t.string :mime_version
      t.string :received
      t.string :ip
      t.string :date
      t.string :message_id
      t.string :content_type
    end
  end

  def self.down
    change_table :emails do |t|
      t.remove :mime_version
      t.remove :received
      t.remove :ip
      t.remove :date
      t.remove :message_id
      t.remove :content_type
    end
  end
end
