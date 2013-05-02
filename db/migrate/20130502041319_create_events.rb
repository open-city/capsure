class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|

      t.datetime :start_date
      t.datetime :end_date
      t.string :name
      t.string :details
      t.string :url
      t.string :contact_details
      t.string :location
      t.datetime :modified_date

      t.references :calendar
      t.timestamps
    end
  end
end
