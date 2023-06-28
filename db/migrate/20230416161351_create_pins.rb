class CreatePins < ActiveRecord::Migration[7.0]
  def change
    create_table :pins do |t|
      t.integer :gpio
      t.integer :state

      t.timestamps
    end
  end
end
