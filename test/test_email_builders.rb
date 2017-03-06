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

    snapshot_path = "test/__snapshots__/#{__method__.to_s}.snapshot.html"
    if ENV["UPDATE_SNAPSHOTS"]
      File.write(snapshot_path, stripped_email_body)
    else
      assert_equal File.read(snapshot_path), stripped_email_body
    end
  end

  def test_format_date_formats_date_correctly
    assert_equal "Saturday, February 25", format_date(DateTime.new(2017, 02, 25))
  end

  def test_google_calendar_event_link_returns_correct_link_if_dates_are_equal
    expected_url = "https://calendar.google.com/calendar/render?action=TEMPLATE&text=Test+show+1&dates=20150530T220000/20150531T000000&location=Your+mom's+house&details=https://buydemtickets.com/test-show-1"
    assert_equal expected_url, google_calendar_event_link(Show.new(
        name: "Test show 1",
        venue: "Your mom's house",
        start_date: DateTime.new(2015, 05, 30),
        end_date: DateTime.new(2015, 05, 30),
        url: "https://buydemtickets.com/test-show-1",
    ))
  end

  def test_google_calendar_event_link_returns_correct_link_if_dates_are_not_equal
    expected_url = "https://calendar.google.com/calendar/render?action=TEMPLATE&text=Test+show+1&dates=20150530/20150531&location=Your+mom's+house&details=https://buydemtickets.com/test-show-1"
    assert_equal expected_url, google_calendar_event_link(Show.new(
        name: "Test show 1",
        venue: "Your mom's house",
        start_date: DateTime.new(2015, 05, 30),
        end_date: DateTime.new(2015, 05, 31),
        url: "https://buydemtickets.com/test-show-1",
    ))
  end

  private

  def stub_unseen_shows(unseen_shows)
    Show.stubs(:unseen).returns(unseen_shows)
  end
end
