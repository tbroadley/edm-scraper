require 'date'
require 'minitest/autorun'
require 'mocha/mini_test'

require_relative '../lib/models/show'
require_relative '../lib/email_builders'

class TestEmailBuilders < Minitest::Test
  def test_email_subject_returns_correct_string_with_one_show
    stub_unseen_shows([
      Show.new(
        name: "Your favourite artist",
      ),
    ])

    assert_equal "Your favourite artist is coming to Toronto!", email_subject
  end

  def test_email_subject_returns_correct_string_with_two_shows
    stub_unseen_shows([
      Show.new(
        name: "Your favourite artist",
      ),
      Show.new(
        name: "this random guy",
      ),
    ])

    assert_equal "Your favourite artist and this random guy are coming to Toronto!", email_subject
  end

  def test_email_subject_returns_correct_string_with_three_shows
    stub_unseen_shows([
      Show.new(
        name: "Your favourite artist",
      ),
      Show.new(
        name: "this random guy",
      ),
      Show.new(
        name: "someone else",
      ),
    ])

    assert_equal "Your favourite artist, this random guy, and someone else are coming to Toronto!", email_subject
  end

  def test_email_subject_returns_correct_string_with_more_than_three_shows
    stub_unseen_shows([
      Show.new(
        name: "Your favourite artist",
      ),
      Show.new(
        name: "this random guy",
      ),
      Show.new(
        name: "someone else",
      ),
      Show.new(
        name: "a nobody",
      ),
      Show.new(
        name: "a bigshot",
      ),
    ])

    assert_equal "Your favourite artist, this random guy, someone else, and 2 others are coming to Toronto!", email_subject
  end

  def test_email_body_renders_correctly
    stub_unseen_shows([
      Show.new(
        name: "Test show 1",
        venue: "Your mom's house",
        start_date: DateTime.new(2015, 05, 30),
        end_date: DateTime.new(2015, 05, 30),
        url: "https://buydemtickets.com/test-show-1",
      ),
      Show.new(
        name: "Test festival (aka Testival)",
        venue: "Woodbine Park",
        start_date: DateTime.new(2015, 07, 15),
        end_date: DateTime.new(2015, 07, 18),
        url: "http://tickytickies.ca/testival",
      ),
    ])

    stripped_email_body = email_body.split("\n").map(&:rstrip).join("\n") + "\n"
    assert_equal File.read("test/__snapshots__/#{__method__.to_s}.snapshot.html"), stripped_email_body
  end

  def test_format_date_formats_date_correctly
    assert_equal "Saturday, February 25", format_date(DateTime.new(2017, 02, 25))
  end

  private

  def stub_unseen_shows(unseen_shows)
    Show.stubs(:unseen).returns(unseen_shows)
  end
end
