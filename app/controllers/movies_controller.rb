class MoviesController < ApplicationController
  before_action :authenticate_user!
  def index
    @movies = Movie.all.order(created_at: :desc)
  end

  def show
    @movie = Movie.find(params[:id])
    @movie_comment = MovieComment.new
    @user = @movie.user
  end

  def new
    @movie = Movie.new
  end

  def edit
     @movie = Movie.find(params[:id])
    unless @movie.user.id == current_user.id
      redirect_to movies_path
    end
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user_id = current_user.id
    if @movie.save
      flash[:notice] = "You have created movie successfully."
      redirect_to movies_path
    else
      render :new
    end

  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      flash[:notice] = "You have updated movie successfully."
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :body, :movie_image, :star)
  end

end
