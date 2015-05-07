class PostsController < ApplicationController
  before_action :authenticate_user!, only: :destroy

  # GET /posts
  # GET /posts.json
  def index
    @posts = article.posts
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    post
    article
  end

  # GET /posts/new
  def new
    article
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    post
    article
  end

  # POST /posts
  # POST /posts.json
  def create
    article
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        success_create(format, @article, 'Post was successfully created.', :created)
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    article
    respond_to do |format|
      if post.update(post_params)
        success_create(format, post, 'Post was successfully updated.', :ok)
      else
        format.html { render :edit }
        format.json { render json: post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    article
    post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def post
    @post ||= Post.find(params[:id])
  end

  def article
    @article ||= Article.find(params[:article_id])
  end

  def success_create(format, model, msg, status)
    format.html { redirect_to model, notice: msg }
    format.json { render :show, status: status, location: model }
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:author, :body, :article_id)
  end
end
