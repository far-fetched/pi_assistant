class Action < ApplicationRecord
  has_one :timer
  belongs_to :series, optional: true
end
