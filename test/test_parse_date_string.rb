require 'date'
require 'minitest/autorun'
require 'mocha/mini_test'

require_relative '../lib/parse_date_string'

class TestParseDateString < Minitest::Test
  def setup
    DateTime.stubs(:now).returns(DateTime.new(2005, 6, 30))
  end

  def test_parsing_date_string_without_suffix
    assert_equal DateTime.new(2005, 8, 23), parse_date_string("Thursday, August 23")
  end

  def test_parsing_date_string_with_suffix
    assert_equal DateTime.new(2005, 11, 2), parse_date_string("Friday, November 2nd")
  end

  def test_parsing_date_with_weekday_abbreviation
    assert_equal DateTime.new(2005, 7, 31), parse_date_string("Sun, July 31st")
  end

  def test_parsing_date_in_next_year
    assert_equal DateTime.new(2006, 1, 10), parse_date_string("Monday, January 10th")
  end

  def test_parsing_date_in_last_week
    assert_equal DateTime.new(2005, 6, 23), parse_date_string("Thursday, June 23th")
  end

  def test_parsing_date_older_than_last_week
    assert_equal DateTime.new(2006, 6, 22), parse_date_string("Thursday, June 22rd")
  end

  def test_parse_date_string_2_parses_dates_correctly
    (DateTime.new(2005, 1, 1)..DateTime.new(2005, 12, 31)).each do |datetime|
      assert_equal datetime, parse_date_string_2(datetime.strftime("%A, %B %-d, %Y"))
    end
  end
end
