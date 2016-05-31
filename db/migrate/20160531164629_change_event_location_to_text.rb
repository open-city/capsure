class ChangeEventLocationToText < ActiveRecord::Migration
  def up
    change_column :events, :location, :text
  end

  def down
    change_column :events, :location, :string
  end
end
