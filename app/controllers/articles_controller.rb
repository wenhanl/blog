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
    @article = Article.new(params.require(:article).permit(:title, :text, :pic))
    tag_arr = params[:article][:tag].split(',')


    if @article.save
      Article.transaction do
        tag_arr.each do |name|
          # create a new tag only if tag.name not exist
          tag = Tag.find_or_create_by(name: name.strip! || name)

          # Update tag blog_count
          if tag.blog_count
            tag.blog_count += 1
          else
            tag.blog_count = 1
          end
          tag.save

          # Push current to current article
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

    # Clear all tags associated with article to edit
    if not @article.tag.nil?
      @article.tag.each do |t|
        t.blog_count -= 1
        if t.blog_count == 0
          t.delete
        else
          t.save
        end
      end
    end
    @article.tag.delete_all

    tag_arr = params[:article][:tag].split(',')

    if @article.update(params.require(:article).permit(:title, :text, :pic))
      Article.transaction do
        tag_arr.each do |name|
          # create a new tag only if tag.name not exist
          tag = Tag.find_or_create_by(name: name.strip! || name)

          # Update tag blog_count
          if tag.blog_count
            tag.blog_count += 1
          else
            tag.blog_count = 1
          end
          tag.save

          # Push current to current article
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
    File.open(Rails.root.join('public', 'uploads',
                              uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
  end

  def destroy
    @article = Article.find(params[:id])

    if not @article.tag.nil?
      @article.tag.each do |t|
        t.blog_count -= 1
        if t.blog_count == 0
          t.delete
        else
          t.save
        end
      end
    end
    @article.destroy

    redirect_to articles_path
  end
end
