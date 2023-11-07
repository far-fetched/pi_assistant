class CreateTimers < ActiveRecord::Migration[7.0]
  def change
    create_table :timers do |t|
      t.string :value
      t.references :action, null: false, foreign_key: true

      t.timestamps
    end
  end
end
