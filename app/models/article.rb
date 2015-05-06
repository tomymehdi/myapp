class Article < ActiveRecord::Base
	has_many :posts
	validates :name, presence: true,
                    length: { minimum: 5 }
end
