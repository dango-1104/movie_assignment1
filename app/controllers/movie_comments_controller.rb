class MovieCommentsController < ApplicationController
  def create
    movie = Movie.find(params[:movie_id])
    comment = current_user.movie_comments.new(movie_comment_params)
    comment.movie_id = movie.id
    comment.save
    redirect_to movie_path(movie)
  end

  def destroy
    MovieComment.find_by(id: params[:id], movie_id: params[:movie_id]).destroy
    redirect_to movie_path(params[:movie_id])
  end

  def show
    @movie = Movie.find(params[:id])
    @movie_comment = MovieComment.new
  end

  private

  def movie_comment_params
    params.require(:movie_comment).permit(:comment)
  end
end