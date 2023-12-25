class AddSeriesRefToActions < ActiveRecord::Migration[7.0]
  def change
    add_reference :actions, :series, null: true, foreign_key: true
  end
end
