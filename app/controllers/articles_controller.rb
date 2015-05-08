class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  def show
    article
  end

  # GET /articles/:id/edit
  def edit
    article
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    article
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: (t :success_destroy) }
      format.json { head :no_content }
    end
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: (t :success_create) }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    article
    respond_to do |format|
      if article.update(article_params)
        format.html { redirect_to @article, notice: (t :success_update) }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :edit }
        format.json { render json: article.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def article
    @article ||= Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:name, :article_id)
  end
end
