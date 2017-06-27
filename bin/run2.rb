require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

welcome
film = get_film_from_user
show_movies(film)