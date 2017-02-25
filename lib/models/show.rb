require_relative '../../environment'

class Show < ActiveRecord::Base
  validates :name, :venue, :start_date, :end_date, :url, :new, presence: true
  validates :name, uniqueness: { scope: [:venue, :start_date, :end_date] }

  scope :unseen, -> { where(new: true) }
end
