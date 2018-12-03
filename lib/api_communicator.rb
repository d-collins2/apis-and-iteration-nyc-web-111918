require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  url = 'http://www.swapi.co/api/people/'
  response = response_hash(url)
  char_film_urls = character_films(response, character_name)
  char_film_urls[character_name].map { |film_url| response_hash(film_url) }
end #end of get_character_movies_from_api

def character_films(hash, character_name)
  films = {}
  hash["results"].map { |data| films[character_name] = data["films"] }
  films
end

def response_hash(url)
  response_string = RestClient.get(url)
  JSON.parse(response_string)
end

def print_movies(films)
  puts "-----------------------------------------"
  films.each do |data|
    puts "Star Wars: #{data["title"]}."
    puts "Episode: #{data["episode_id"]}."
    puts "Director: #{data["director"]}."
    puts "Description #{data["opening_crawl"][0...150]}..."
    puts "-----------------------------------------"
  end
end #end of print_movies

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS



# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
