require 'minitest/autorun'
require 'mocha/mini_test'

require_relative '../lib/filter_artist'

class TestParseDateString < Minitest::Test
  def test_filter_artist_returns_false_for_artist_not_in_the_list
    refute filter_artist?('Justin Bieber')
  end

  def test_filter_artist_returns_true_for_artist_included_in_show_name
    assert filter_artist?('Dank memes with Dillon Francis and other people')
  end

  def test_filter_artist_returns_false_for_artist_included_in_a_word
    refute filter_artist?('Evergrey')
  end
end
