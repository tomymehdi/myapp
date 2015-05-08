require 'rails_helper'

describe PostsController do
  let!(:user) { create(:user) }
  describe '#create' do
    context 'with valid params' do
      it 'redirects to show page'
    end
    context 'with invalid params' do
      it 're-renders #new form'
    end
  end

  describe '#update' do
    context 'with valid params' do
      it 'redirects to show page'
    end
    context 'with invalid params' do
      it 're-renders #new form'
    end
  end

  describe '#destroy' do
    context 'when a post exists for an article' do
      let!(:article) { create(:article) }
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
            response.should redirect_to article
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
        before :each do
          # sign_inn user
        end
        it 'redirects to authentication' do
          delete :destroy, article_id: article.id, id: post.id
          expect(response).to redirect_to( new_user_session_path )
        end
      end
    end
  end
end
