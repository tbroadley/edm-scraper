require_relative '../../environment'

class Show < ActiveRecord::Base
  validates :name, uniqueness: { scope: [:venue, :start_date, :end_date] }
end
