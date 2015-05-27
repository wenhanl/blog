class Tag < ActiveRecord::Base
	has_and_belongs_to_many :article, :uniq => true
end