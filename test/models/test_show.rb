# frozen_string_literal: true

require 'date'
require 'minitest/autorun'
require 'mocha/mini_test'

require_relative '../../lib/models/show'

# rubocop:disable Metrics/MethodLength

class TestShow < Minitest::Test
  def test_show_without_new_or_url_is_valid
    date = Time.new(2005, 1, 1)
    show = Show.new(
      name: 'Test',
      venue: 'Test',
      start_date: date,
      end_date: date,
      filter: false
    )
    assert show.valid?
  end

  def test_show_with_non_boolean_filter_is_valid
    date = Time.new(2005, 1, 1)
    show = Show.new(
      name: 'Test',
      venue: 'Test',
      start_date: date,
      end_date: date,
      filter: 'not a boolean'
    )
    assert show.valid?
    assert_equal true, show.filter
  end

  def test_show_to_s_if_start_date_and_end_date_are_same
    name = 'Test show'
    venue = 'Club 1'
    date = Time.new(2005, 1, 1)
    show = Show.new(
      name: name,
      venue: venue,
      start_date: date,
      end_date: date
    )

    assert_equal "#{name} at #{venue} on #{date}", show.to_s
  end

  def test_show_to_s_if_start_date_and_end_date_are_different
    name = 'Test show'
    venue = 'Club 1'
    start_date = Time.new(2005, 1, 1)
    end_date = Time.new(2005, 1, 5)
    show = Show.new(
      name: name,
      venue: venue,
      start_date: start_date,
      end_date: end_date
    )

    assert_equal "#{name} at #{venue} from #{start_date} to #{end_date}",
                 show.to_s
  end
end

show_properties = {
  name: 'Test',
  venue: 'Test',
  start_date: Time.new(2005, 1, 1),
  end_date: Time.new(2005, 1, 1),
  filter: true
}

show_properties.each_key do |key|
  TestShow.send(:define_method, "test_show_without_#{key}_is_invalid") do
    modified_show_properties = show_properties.clone
    modified_show_properties.delete(key)
    refute Show.new(modified_show_properties).valid?
  end
end
