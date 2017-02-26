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
  else
    "#{first}, #{second}, #{third}, and #{Show.unseen.count - 3} others are"
  end + " coming to Toronto!"
end

def email_body
  b = binding
  b.local_variable_set(:shows, Show.unseen)
  ERB.new(File.read('lib/mailers/show_mailer.html.erb')).result(b)
end

def format_date(date)
  date.strftime("%A, %B %-d")
end

def google_calendar_event_link(show)
  date_format_string = '%Y%m%d'
  "https://calendar.google.com/calendar/render" \
    "?action=TEMPLATE" \
    "&text=#{show.name}" \
    "&dates=#{show.start_date.strftime(date_format_string)}/#{show.end_date.strftime(date_format_string)}" \
    "&location=#{show.venue}" \
    "&details=#{show.url}".gsub(" ", "+")
end
