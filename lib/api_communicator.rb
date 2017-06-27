require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  #all_characters = RestClient.get('http://www.swapi.co/api/people/')
  #character_hash = JSON.parse(all_characters)

# iterate over the character hash to find the collection of `films` for the given
  #   `character`
  person_hash = find_character(character)

  #collect those film API urls, make a web request to each URL to get the info
  #  for that film
  film_info(person_hash)
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film

  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def find_character(character)
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  #searches character_hash of all characters
  #if input matches character's name, return hash of character data
  character_hash["results"].each do |person|
    if person["name"].downcase == character.downcase
      return person
    end
  end
end

def film_info(person_hash)
  person_hash["films"].map do |url|
    info = RestClient.get(url)
    films = JSON.parse(info)
  end
end

def parse_character_movies(films_hash)
  n = 1
  films_hash.each do |film|
    puts "#{n}. #{film["title"]}"
    n += 1
  end
  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
