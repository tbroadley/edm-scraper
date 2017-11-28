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
    refute filter_artist?('Pentaweezer')
  end

  def test_filter_artist_works_if_show_contains_punctuation
    assert filter_artist?('Weezer, Pixies & The Wombats')
    assert filter_artist?('Weezer: The White Album Live')
    assert filter_artist?('This is a Weezer show')
    assert filter_artist?('A bad band (Weezer)')
  end

  def test_filter_artist_ignores_capitalization
    assert filter_artist?('WEEZER')
    assert filter_artist?('weezer')
  end
end
