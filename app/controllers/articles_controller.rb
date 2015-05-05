class ArticlesController < ApplicationController

	# GET /articles
	# GET /articles.json
	def index
	  @articles = Article.all
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

end
