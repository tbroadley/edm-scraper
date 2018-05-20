# frozen_string_literal: true

require_relative '../../environment'

# Change filter to mean that only shows with filter = false should be
# displayed.
class ChangeFilterColumn < ActiveRecord::Migration[4.2]
  def up
    Show.where(filter: true).each do |show|
      show.filter = !filter_artist?(show.name)
      show.save!
    end
  end
end

ChangeFilterColumn.migrate(ARGV[0])
