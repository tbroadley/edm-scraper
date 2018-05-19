# frozen_string_literal: true

require_relative '../../environment'

# Add a column called filter. When this column is true, run the artist filter
# against the show.
class AddFilterColumn < ActiveRecord::Migration[4.2]
  def up
    add_column :shows, :filter, :boolean
    Show.update_all(filter: false)
  end

  def down
    remove_column :shows, :filter
  end
end

AddFilterColumn.migrate(ARGV[0])
