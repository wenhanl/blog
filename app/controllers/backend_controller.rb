class BackendController < ApplicationController

	before_action :authenticate_admin!
	def index
		@articles = Article.all.order(created_at: :desc)
	@tags = Tag.all
	end
end