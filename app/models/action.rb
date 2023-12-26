class Action < ApplicationRecord
  has_one :timer, as: :schedulable
  belongs_to :series, optional: true
end
