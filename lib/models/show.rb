require_relative '../../environment'

class Show < ActiveRecord::Base
  validates :name, :venue, :start_date, :end_date, presence: true
  validates :new, :filter, inclusion: [true, false]
  validates :name, uniqueness: { scope: [:venue, :start_date, :end_date] }

  scope :unseen, -> {
    where(new: true)
      .order(start_date: :asc, end_date: :asc, name: :asc)
      .select { |show| !show.filter || filter_artist?(show.name) }
  }
end
