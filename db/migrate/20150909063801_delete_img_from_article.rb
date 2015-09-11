class DeleteImgFromArticle < ActiveRecord::Migration
  def change
  	remove_column :articles, :img
  end
end
