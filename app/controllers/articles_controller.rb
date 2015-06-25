class ArticlesController < ApplicationController
	include ArticlesHelper
	#http_basic_authenticate_with name: "admin", password: "1", except: [:index, :show]

  before_action :authenticate_admin!, except: [:index, :show]

	def index
		@articles = Article.all.order(created_at: :desc)
		@tags = Tag.all
	end

	def new
	  	@article = Article.new
	end

	def create
		@article = Article.new(params.require(:article).permit(:title, :text, :img))
		tag_arr = params[:article][:tag].split(',')
 		
 		
		if @article.save
		  Article.transaction do
			  tag_arr.each do |name|
					tag = Tag.find_or_create_by(name: name.strip! || name) # create a new tag only if tag.name not exist
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

    	tag_arr = params[:article][:tag].split(',')

		if @article.update(params.require(:article).permit(:title, :text, :img))
      		Article.transaction do
		        tag_arr.each do |name|
		          tag = Tag.find_or_create_by(name: name.strip! || name) # create a new tag only if tag.name not exist
		          @article.tag.push(tag)
		        end
      		end
	    	redirect_to @article
   		else
	    	render 'edit'
	    end
	end

	def upload
		uploaded_io = params[:article][:img] 
		File.open(Rails.root.join('public','uploads',
uploaded_io.original_filename),'wb') do |file|
			file.write(uploaded_io.read)
		end
	end

	def destroy
		@article = Article.find(params[:id])
 		@article.destroy
 
  	redirect_to articles_path
	end
end
