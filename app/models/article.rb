class Article < ActiveRecord::Base
	has_and_belongs_to_many :tag
	validates :title, presence: true,
                    length: { minimum: 5 }
end
