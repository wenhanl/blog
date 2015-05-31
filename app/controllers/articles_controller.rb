class ArticlesController < ApplicationController
	include ArticlesHelper
	#http_basic_authenticate_with name: "admin", password: "1", except: [:index, :show]

	def index
		@articles = Article.all
	end

	def new
	  	@article = Article.new
	end

	def create
		@article = Article.new(article_params)
		tag_arr = params[:tag].split(',')
 		
 		
		if @article.save
		  Article.transaction do
			  tag_arr.each do |name|
					tag = Tag.find_or_create_by(name: name) # create a new tag only if tag.name not exist
					@article.tag.push(tag)
			  end
			 end
		  redirect_to @article
		else
		  render 'new'
		end

	end

	def edit
		@article = Article.find(params[:id])
	end

	def show
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])
    @article.tag.delete_all

    tag_arr = params[:tag].split(',')

		if @article.update(article_params)
      Article.transaction do
        tag_arr.each do |name|
          tag = Tag.find_or_create_by(name: name) # create a new tag only if tag.name not exist
          @article.tag.push(tag)
        end
      end
	    redirect_to @article
    else
      render 'edit'
    end
	end

	def destroy
		@article = Article.find(params[:id])
 		@article.destroy
 
  	redirect_to articles_path
	end
end
