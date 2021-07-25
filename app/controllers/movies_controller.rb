class MoviesController < ApplicationController
  before_action :authenticate_user!
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
    @movie_comment = MovieComment.new
  end

  def new
    @movie = Movie.new
  end

  def edit

  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user_id = current_user.id
    if @movie.save
      redirect_to movies_path
    else
      render :new
    end

  end

  def update

  end

  def destroy

  end

  private
  def movie_params
    params.require(:movie).permit(:title, :body, :movie_image, :star)
  end

end
