class ChangeReferenceOfTimerToPolymorphic < ActiveRecord::Migration[7.0]
  def up
    remove_reference :timers, :action, null: false, foreign_key: true
    add_reference :timers, :schedulable, polymorphic: true, null: true
  end

  def down
    remove_reference :timers, :schedulable, polymorphic: true, null: true
    add_reference :timers, :action, null: true, foreign_key: true
  end
end
