# frozen_string_literal: true

require 'erb'

require_relative '../environment'
require_relative 'models/show'

MAX_SHOWS_PER_EMAIL = 25

# Add String#truncate, which returns the string if it is less than 40
# characters. Otherwise, it truncates it to 40 characters and adds an ellipsis
# to the end.
class String
  def truncate
    length > 40 ? "#{self[0..39]}..." : self
  end
end

# rubocop:disable Metrics/MethodLength
def email_subject(shows)
  first, second, third = shows.map(&:name).map(&:truncate)

  case Show.unseen.count
  when 1
    "#{first} is"
  when 2
    "#{first} and #{second} are"
  when 3
    "#{first}, #{second}, and #{third} are"
  when 4
    "#{first}, #{second}, #{third}, and 1 other are"
  else
    "#{first}, #{second}, #{third}, and #{Show.unseen.count - 3} others are"
  end + ' coming to a venue near you!'
end
# rubocop:enable Metrics/MethodLength

def email_body(shows)
  b = binding
  b.local_variable_set(:shows, shows)
  ERB.new(File.read('lib/mailers/show_mailer.html.erb')).result(b)
end

def emails
  show_groups = Show.unseen.each_slice(MAX_SHOWS_PER_EMAIL).to_a
  show_groups.map do |group|
    { subject: email_subject(group), body: email_body(group) }
  end
end

def format_date(date)
  date.strftime('%A, %B %-d')
end

def google_calendar_date_string(show)
  date_format_string = '%Y%m%d'
  if show.start_date == show.end_date
    "#{show.start_date.strftime(date_format_string)}T220000" \
    "/#{(show.end_date + 1.day).strftime(date_format_string)}T000000"
  else
    "#{show.start_date.strftime(date_format_string)}" \
    "/#{show.end_date.strftime(date_format_string)}"
  end
end

def google_calendar_event_link(show)
  'https://calendar.google.com/calendar/render' \
    '?action=TEMPLATE' \
    "&text=#{show.name}" \
    "&dates=#{google_calendar_date_string(show)}" \
    "&location=#{show.venue}" \
    "&details=#{show.url}".tr(' ', '+')
end
