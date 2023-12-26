class Timer < ApplicationRecord
  belongs_to :schedulable, polymorphic: true

  def interval?

  end
end
