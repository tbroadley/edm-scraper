require_relative '../config/filter_artists_list'

def filter_artist?(show_name)
  FILTER_ARTISTS_LIST.map(&:downcase).any? do |artist|
    show_name.downcase.split(' ').include?(artist)
  end
end
