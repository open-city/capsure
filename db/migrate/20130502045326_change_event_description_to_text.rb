class ChangeEventDescriptionToText < ActiveRecord::Migration
  def up
    change_column :events, :details, :text
  end

  def down
    change_column :events, :details, :string
  end
end
