require_relative '../../environment'

class CreateShowsTable < ActiveRecord::Migration
  def up
    create_table :shows do |t|
      t.string :name
      t.string :venue
      t.datetime :start_date
      t.datetime :end_date
      t.string :url
      t.boolean :new, default: :true
    end
  end

  def down
    drop_table :shows
  end
end

CreateShowsTable.migrate(ARGV[0])
