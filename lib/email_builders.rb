# frozen_string_literal: true

require 'erb'

require_relative '../environment'
require_relative 'models/show'

class String
  def truncate
    length > 40 ? "#{self[0..39]}..." : self
  end
end

def email_subject
  first, second, third = Show.unseen.map(&:name).map(&:truncate)

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
  end + ' coming to Toronto!'
end

def email_body
  b = binding
  b.local_variable_set(:shows, Show.unseen)
  ERB.new(File.read('lib/mailers/show_mailer.html.erb')).result(b)
end

def format_date(date)
  date.strftime('%A, %B %-d')
end

def google_calendar_event_link(show)
  date_format_string = '%Y%m%d'
  dates = if show.start_date == show.end_date
            "#{show.start_date.strftime(date_format_string)}T220000" \
            "/#{(show.end_date + 1.day).strftime(date_format_string)}T000000"
          else
            "#{show.start_date.strftime(date_format_string)}" \
            "/#{show.end_date.strftime(date_format_string)}"
  end
  'https://calendar.google.com/calendar/render' \
    '?action=TEMPLATE' \
    "&text=#{show.name}" \
    "&dates=#{dates}" \
    "&location=#{show.venue}" \
    "&details=#{show.url}".tr(' ', '+')
end
