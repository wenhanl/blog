class Article < ActiveRecord::Base
	has_and_belongs_to_many :tag, :uniq => true
	validates :title, presence: true,
                    length: { minimum: 5 }

    has_attached_file :pic, :styles => { :small => "240>" },
    					:url  => "/article_cover/:id/:style_:basename.:extension",
    					:path => ":rails_root/public/article_cover/:id/:style_:basename.:extension"

    validates_attachment_content_type :pic, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
