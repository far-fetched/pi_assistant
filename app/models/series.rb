class Series < ApplicationRecord
  has_one :timer, as: :schedulable
  has_many :actions
end
