require_relative '../../environment'

class Show < ActiveRecord::Base
  validates :name, :venue, :start_date, :end_date, :new, :filter, presence: true
  validates :name, uniqueness: { scope: [:venue, :start_date, :end_date] }

  scope :unseen, -> {
    where(new: true).select { |show| !show.filter || filter_artist?(show.name) }
  }
end
