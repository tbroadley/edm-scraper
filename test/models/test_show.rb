require 'date'
require 'minitest/autorun'
require 'mocha/mini_test'

require_relative '../../lib/models/show'

class TestShow < Minitest::Test
  def test_show_is_valid
    date = DateTime.new(2005, 1, 1)
    show = Show.new(name: 'Test', venue: 'Test', start_date: date, end_date: date, new: true, filter: false)
    assert show.valid?
  end

  def test_show_without_name_is_invalid
    date = DateTime.new(2005, 1, 1)
    show = Show.new(venue: 'Test', start_date: date, end_date: date)
    refute show.valid?
  end

  def test_show_without_venue_is_invalid
    date = DateTime.new(2005, 1, 1)
    show = Show.new(name: 'Test', start_date: date, end_date: date)
    refute show.valid?
  end

  def test_show_without_name_is_invalid
    show = Show.new(name: 'Test', venue: 'Test', start_date: DateTime.new(2005, 1, 1))
    refute show.valid?
  end

  def test_show_with_non_boolean_new_is_invalid
    date = DateTime.new(2005, 1, 1)
    show = Show.new(name: 'Test', venue: 'Test', start_date: date, end_date: date, new: 'not a boolean')
    refute show.valid?
  end

  def test_show_to_s_if_start_date_and_end_date_are_same
    name = 'Test show'
    venue = 'Club 1'
    date = DateTime.new(2005, 1, 1)
    show = Show.new(name: name, venue: venue, start_date: date, end_date: date)

    assert_equal "#{name} at #{venue} on #{date}", show.to_s
  end

  def test_show_to_s_if_start_date_and_end_date_are_different
    name = 'Test show'
    venue = 'Club 1'
    start_date = DateTime.new(2005, 1, 1)
    end_date = DateTime.new(2005, 1, 5)
    show = Show.new(name: name, venue: venue, start_date: start_date, end_date: end_date)

    assert_equal "#{name} at #{venue} from #{start_date} to #{end_date}", show.to_s
  end
end
