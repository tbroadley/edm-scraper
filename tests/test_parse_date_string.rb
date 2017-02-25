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
end