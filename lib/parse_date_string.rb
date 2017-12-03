def parse_date_string(date_string)
  _, month_name, day = /(.*), (.*) (\d*)/.match(date_string).captures
  cleaned_month_name = month_name.gsub(/[^A-Za-z]/, '').downcase
  month = Date::MONTHNAMES[1..-1]
          .map(&:downcase)
          .find_index { |name| name.start_with?(cleaned_month_name) } + 1
  year = Time.now.strftime('%Y').to_i
  date = Time.new(year, month, day.to_i)
  date < (Time.now - 1.week) ? date.next_year : date
end

def parse_date_string_2(date_string)
  _, month_and_day, year = date_string.split(', ')
  month_name, day = month_and_day.split(' ')
  month = Date::MONTHNAMES.index(month_name)
  Time.new(year.to_i, month.to_i, day.to_i)
end
