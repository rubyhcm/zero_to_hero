class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy purge_avatar]
  invisible_captcha only: [:create, :update]

  # GET /articles or /articles.json
  def index
    @pagy, @articles = pagy(Article.order(created_at: :desc))
  end

  # GET /articles/1 or /articles/1.json
  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@article.id}"
        # {@article.id} la pdf file name
        # neu khong chi dinh template thi se lay theo ten action
        # render pdf: "#{@article.id}", template: "articles/ten_template" ex: articles/show
      end
    end
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article was successfully created and sent to telegram." }
        format.json { render :show, status: :created, location: @article }
        TelegramMailer.send_group_message(params[:article][:content]).deliver_now
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      # delete iamges because of array
      @article.images.purge if article_params[:avatar]
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy!
    @article.images.purge

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def purge_avatar
    @article.avatar.purge
    redirect_back fallback_location: root_path, notice: "success"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content, :avatar, :description, :status, images: [])
    end
end
