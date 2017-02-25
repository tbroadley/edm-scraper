def parse_date_string(date_string)
  _, month_name, day = /(.*), (.*) (\d*)/.match(date_string).captures
  month = Date::MONTHNAMES.index(month_name)
  year = DateTime.now.strftime("%Y").to_i
  date = DateTime.new(year, month, day.to_i)
  date < DateTime.now ? date.next_year : date
end
