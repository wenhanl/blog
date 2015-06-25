class TagsController < ApplicationController
  def show
  	@current_tag = Tag.find(params[:id])
  	@tags = Tag.all
  end
end