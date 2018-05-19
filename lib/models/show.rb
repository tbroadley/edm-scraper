# frozen_string_literal: true

require_relative '../../environment'

# An event with a name, a venue, and a start and end date.
# If new is true, the show has never been included in an email.
# If filter is true, the artist filter should be applied to the show.
class Show < ActiveRecord::Base
  validates :name, :venue, :start_date, :end_date, presence: true
  validates :new, :filter, inclusion: [true, false]
  validates :name, uniqueness: { scope: %i[venue start_date end_date] }

  scope :interesting, lambda {
      where('end_date >= ?', Date.today)
      .order(start_date: :asc, end_date: :asc, name: :asc)
      .select { |show| !show.filter || filter_artist?(show.name) }
  }

  scope :unseen, lambda {
    where(new: true)
      .interesting
  }

  def to_s
    date_description = if start_date == end_date
                         "on #{start_date}"
                       else
                         "from #{start_date} to #{end_date}"
                       end
    "#{name} at #{venue} #{date_description}"
  end

  def save_and_return_message
    if save
      "Added new show: '#{self}'"
    else
      "Show '#{self}' already exists in database"
    end
  end
end
