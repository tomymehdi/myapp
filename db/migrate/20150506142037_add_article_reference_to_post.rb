class AddArticleReferenceToPost < ActiveRecord::Migration
  def change
    add_reference :posts, :article, index: true, foreign_key: true
  end
end
