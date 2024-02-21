class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :title
      t.time :start_date
      t.integer :duration
      t.text :description
      t.string :location
      t.integer :price

      t.belongs_to :admin, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
