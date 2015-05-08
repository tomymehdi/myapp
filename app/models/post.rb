class Post < ActiveRecord::Base
  belongs_to :article
  validates :article_id, presence: true
  validates :author,  presence: true, length: { minimum: 5 }
  validates :body,  presence: true, length: { minimum: 5 }
end
