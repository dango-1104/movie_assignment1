class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search_result
    @range = params[:range]
    @word = params[:word]

    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    else
      @movies = Movie.looks(params[:search], params[:word])
    end
  end
end