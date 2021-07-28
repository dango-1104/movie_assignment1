class MovieCommentsController < ApplicationController
  def create
    movie = Movie.find(params[:movie_id])
    comment = current_user.movie_comments.new(movie_comment_params)
    comment.movie_id = movie.id
    if comment.save
      redirect_to movie_movie_comments_path(movie_id: movie.id)
    else
      render movies_path
    end
  end

  def destroy
    comment = MovieComment.find_by(id: params[:id], movie_id: params[:movie_id])
    if comment.destroy
      redirect_to movie_movie_comments_path(movie_id: params[:movie_id])
    else
      render movies_path
    end
  end

  def index
    @movie = Movie.find(params[:movie_id])
    @movie_comment = MovieComment.new
  end

  private

  def movie_comment_params
    params.require(:movie_comment).permit(:comment)
  end
end