class CreateLocators < ActiveRecord::Migration
  def self.up
    create_table :locators do |t|
      t.string :url
      t.timestamps
    end
  end

  def self.down
    drop_table :locators
  end
end
