class CreateReferrers < ActiveRecord::Migration
  def self.up
    create_table :referrers do |t|
      t.string :name
      t.integer :locator_id
      t.integer :hit

      t.timestamps
    end
  end

  def self.down
    drop_table :referrers
  end
end
