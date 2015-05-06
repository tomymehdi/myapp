class ArticlesController < ApplicationController
	before_action :set_article, only: [:show]

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
  end

  # GET /articless/1/edit
  def edit
  end

	# POST /articles
	# POST /articles.json
	def create
		@article = Article.new(article_params)

		respond_to do |format|
		  if @article.save
		    format.html { redirect_to @article, notice: 'Article was successfully created.' }
		    format.json { render :show, status: :created, location: @article }
		  else
		    format.html { render :new }
		    format.json { render json: @article.errors, status: :unprocessable_entity }
		  end
		end
	end

	private

		def article_params
			params.require(:article).permit(:name)
		end

		def set_article
			@article = Article.find(params[:id])
		end

end
