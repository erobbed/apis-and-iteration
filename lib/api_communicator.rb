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
  page_num = 1
  loop do
    page_characters = RestClient.get('http://www.swapi.co/api/people/?page=' + page_num.to_s)
    character_hash = JSON.parse(page_characters)
    #searches character_hash of all characters
    #if input matches character's name, return hash of character data
    character_hash["results"].each do |person|
      if person["name"].downcase == character.downcase
        return person
      end
    end
    page_num += 1
    #binding.pry
    break if (character_hash["next"] == nil)
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

def get_movie_info_from_api(film)
  film_hash = find_film(film)
end

def find_film(film)
  page_films = RestClient.get('http://www.swapi.co/api/films/')
  movie_hash = JSON.parse(page_films)
  #searches character_hash of all characters
  #if input matches character's name, return hash of character data
  movie_hash["results"].each do |movie|
    if movie["title"].downcase == film.downcase
      return movie
    end
    #binding.pry
  end
end

def parse_movies(film_hash)
  film_hash.each do |key, value|
    puts "#{key}: #{value}"
  end
  # some iteration magic and puts out the movies in a nice list
end

def show_movies(film)
  film_hash = get_movie_info_from_api(film)
  parse_movies(film_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
