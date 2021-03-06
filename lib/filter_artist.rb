# frozen_string_literal: true

require_relative '../config/filter_artists_list'

def filter_artist?(show_name)
  FILTER_ARTISTS_LIST.any? do |artist|
    escaped_artist = Regexp.escape(artist)
    Regexp.new(
      "((^#{escaped_artist})|([ (]#{escaped_artist}))[ ),:]?",
      Regexp::IGNORECASE
    ).match(show_name)
  end
end
