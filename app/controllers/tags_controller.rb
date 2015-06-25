class TagsController < ApplicationController
  def show
  	@article = Tag.includes(:article).find(params[:id]).article
  	@tags = Tag.all
  end
end