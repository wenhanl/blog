class CreateJoinTableArticleTag < ActiveRecord::Migration
  def change
	create_table :article_tag, id: false do |t|
      t.belongs_to :article, index: true
      t.belongs_to :tag, index: true
    end
  end
end
