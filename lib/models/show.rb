require_relative '../../environment'

class Show < ActiveRecord::Base
  validates :name, :venue, :start_date, :end_date, presence: true
  validates :new, :filter, inclusion: [true, false]
  validates :name, uniqueness: { scope: %i[venue start_date end_date] }

  scope :unseen, -> {
    where(new: true)
      .order(start_date: :asc, end_date: :asc, name: :asc)
      .select { |show| !show.filter || filter_artist?(show.name) }
  }

  def to_s
    date_description = if start_date == end_date
                         "on #{start_date}"
                       else
                         "from #{start_date} to #{end_date}"
    end
    "#{name} at #{venue} #{date_description}"
  end
end
