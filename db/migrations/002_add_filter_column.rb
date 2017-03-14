require_relative '../../environment'

class AddFilterColumn < ActiveRecord::Migration

  def up
    add_column :shows, :filter, :boolean
    Show.update_all(filter: false)
  end

  def down
    remove_column :shows, :filter
  end

end

AddFilterColumn.migrate(ARGV[0])
