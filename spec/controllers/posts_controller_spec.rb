require 'rails_helper'

describe PostsController do
  let!(:user) { create(:user) }
  let!(:article) { create(:article) }
  describe '#create' do
    let!(:new_post) { build(:post, article_id: article.id) }
    context 'when a user is logged' do
      before :each do
        sign_in user
      end
      context 'when a post is created with valid params' do
        it 'increase posts count by 1' do
          expect { post :create, article_id: article.id, post: new_post.attributes }
          .to change(Post, :count).by(1)
        end

        it 'increase article posts count by 1' do
          expect { post :create, article_id: article.id, post: new_post.attributes }
          .to change { article.reload.posts.count }.by(1)
        end

        it 'redirects to article' do
          post :create, article_id: article.id, post: new_post.attributes
          expect(response).to redirect_to article_path(article)
        end
      end
      context 'when tring to create a post with invalid params' do
        let!(:invalid_post) { build(:post, article_id: article.id, body: 'inv') }
        it 're-renders posts#new form' do
          post :create, article_id: article.id, post: invalid_post.attributes
          expect(response).to render_template('new')
        end
      end
    end
    context 'when a user isn\'t logged' do
      it 'redirects to authentication view' do
        post :create, article_id: article.id, post: new_post.attributes
        expect(response).to redirect_to( new_user_session_path )
      end
      context 'when tring to create a post with valid params' do
        it 'doesn\'t increase posts count by 1' do
          expect { post :create, article_id: article.id, post: new_post.attributes }
          .not_to change { Post, :count }
        end

        it 'doesn\'t increase article posts count by 1' do
          expect { post :create, article_id: article.id, post: new_post.attributes }
          .not_to change { article.reload.posts.count }
        end
      end
      context 'when tring to create a post with invalid params' do
        let!(:invalid_post) { build(:post, article_id: article.id, body: 'inv') }
        it 'redirects to authentication view' do
          post :create, article_id: article.id, post: invalid_post.attributes
          expect(response).to redirect_to( new_user_session_path )
        end
      end
    end
  end

  describe '#destroy' do
    context 'when a post exists for an article' do
      let!(:post) { create(:post, article_id: article.id) }
      context 'when a user is logged' do
        before :each do
          sign_in user
        end
        it 'decrease posts count by 1' do
          expect { delete :destroy, article_id: article.id, id: post.id }
          .to change(Post, :count).by(-1)
        end

        it 'decrease posts count from the article by 1' do
          expect { delete :destroy, article_id: article.id, id: post.id }
          .to change { article.reload.posts.count }.by(-1)
        end

        context 'when html requested' do
          it 'redirects to articles#show html' do
            delete :destroy, article_id: article.id, id: post.id
            expect(response).to redirect_to article
          end
        end
        context 'when json requested' do
          before :each do
            request.env['HTTP_ACCEPT'] = 'application/json'
          end
          it 'renders json' do
            delete :destroy, article_id: article.id, id: post.id
            expect(response.status).to eq(204)
          end
        end
      end

      context 'when a user isn\'t logged' do
        it 'redirects to authentication view' do
          delete :destroy, article_id: article.id, id: post.id
          expect(response).to redirect_to( new_user_session_path )
        end
        it 'don\'t change the amount of posts' do
          expect { delete :destroy, article_id: article.id, id: post.id }
          .not_to change { Post.count }
        end
        it 'don\'t change the amount of article posts' do
          expect { delete :destroy, article_id: article.id, id: post.id }
          .not_to change { article.reload.posts.count }
        end
      end
    end
  end
end
