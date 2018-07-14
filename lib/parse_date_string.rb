# frozen_string_literal: true

def month_index(month_name)
  cleaned_month_name = month_name.gsub(/[^A-Za-z]/, '').downcase
  Date::MONTHNAMES[1..-1]
    .map(&:downcase)
    .find_index { |name| name.start_with?(cleaned_month_name) } + 1
end

def decompose_date_string(date_string)
  date_regex_result = /(.*), (.*) (\d*)/.match(date_string)
  return nil if date_regex_result.nil?

  _, month_name, day = date_regex_result.captures
  [month_index(month_name), day.to_i]
end

def parse_date_string(date_string)
  year = Time.now.strftime('%Y').to_i
  month, day = decompose_date_string(date_string)
  return nil if month.nil? || day.nil?

  date = Time.new(year, month, day)
  date < (Time.now - 1.week) ? date.next_year : date
end

def parse_date_string_2(date_string)
  _, month_and_day, year = date_string.split(', ')
  month_name, day = month_and_day.split(' ')
  month = Date::MONTHNAMES.index(month_name)
  Time.new(year.to_i, month.to_i, day.to_i)
end
