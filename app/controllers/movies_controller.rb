class MoviesController < ApplicationController
  def index
    puts "\n\n\nparams #{params}\n\n\n"
    if params[:query].present?
      # @movies = Movie.where(title: params[:query])
      # SELECT * FROM movies WHERE title ILIKE '%super%'
      # query = "title ILIKE :query"
      # query = "title ILIKE :query OR synopsis ILIKE :query"
      # query = <<~SQL
      #   movies.title ILIKE :query
      #   OR movies.synopsis ILIKE :query
      #   OR directors.first_name ILIKE :query
      #   OR directors.last_name ILIKE :query
      # SQL
      # query = <<~SQL
      #   movies.title @@ :query
      #   OR movies.synopsis @@ :query
      #   OR directors.first_name @@ :query
      #   OR directors.last_name @@ :query
      # SQL
      # @movies = Movie.where("title ILIKE ?", "%#{params[:query]}%") #this also works
      # @movies = Movie.where("title ILIKE ? OR synopsis ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")

      # This is active record .joins
      # SELECT * FROM movies JOIN directors ON directors.id = movies.director_id
      # @movies = Movie.joins(:director).where(query, query: "%#{params[:query]}%") # this is more sophisticated
      # @movies = Movie.search_by_title_and_synopsis(params[:query])
      @movies = Movie.global_search(params[:query])
      puts "\n\n\nmovies query #{@movies.to_sql}\n\n\n"

    else
      @movies = Movie.all
    end
  end
end
