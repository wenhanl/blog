class CreateJoinTableArticleTag < ActiveRecord::Migration
  def change
	create_join_table :article, :tag, table_name: :articles_tags do |t|
      t.index [:article_id, :tag_id]
      t.index [:tag_id, :article_id]
    end
  end
end
