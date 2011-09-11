class CreateLocators < ActiveRecord::Migration
  def self.up
    create_table :locators do |t|
      t.string :url
      t.timestamps
    end
    
    # make ID starts at 5000 so that base36 will become more alphanumeric
    # http://stackoverflow.com/questions/692856/set-start-value-for-autoincrement-in-sqlite
    
    # apparently you have to create something first in order to update sqlite_sequence:
    Locator.create( :url => "http://www.flickr.com/photos/amoschapple/5961342507/sizes/o/in/photostream/")
    Locator.delete_all
    
    execute <<-SQL
      UPDATE SQLITE_SEQUENCE SET seq = 5000 WHERE name = 'locators'
    SQL
  end

  def self.down
    drop_table :locators
  end
end
