require_relative '../config/filter_artists_list'

def filter_artist?(show_name)
  FILTER_ARTISTS_LIST.any? do |artist|
    Regexp.new("((^#{artist})|([ (]#{artist}))[ ),:]?", Regexp::IGNORECASE).match(show_name)
  end
end
