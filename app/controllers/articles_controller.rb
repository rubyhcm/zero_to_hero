class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy purge_avatar]
  invisible_captcha only: %i[create update]

  # GET /articles or /articles.json
  def index
    @pagy, @articles = pagy(Article.order(created_at: :desc))
  end

  # GET /articles/1 or /articles/1.json
  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: @article.id.to_s
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
      if save_article_and_send_telegram_message
        format.html { handle_html_response }
        # format.json { handle_json_response }
      else
        format.html { render_new_html }
        # format.json { render_errors_json }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      delete_images_if_needed

      if update_article
        format.html { redirect_to article_url(@article), notice: 'Article was successfully updated.' }
        # format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        # format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy!
    @article.images.purge

    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def purge_avatar
    @article.avatar.purge
    redirect_back fallback_location: root_path, notice: 'success'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :content, :avatar, :description, :status, images: [], tags: [])
  end

  def save_article_and_send_telegram_message
    if @article.save
      TelegramMailer.send_group_message(params[:article][:content]).deliver_now
      true
    else
      false
    end
  end

  def handle_html_response
    redirect_to article_url(@article), notice: 'Article was successfully created and sent to telegram.'
  end

  # def handle_json_response
  #   render :show, status: :created, location: @article
  # end

  def render_new_html
    render :new, status: :unprocessable_entity
  end

  # def render_errors_json
  #   render json: @article.errors, status: :unprocessable_entity
  # end

  def delete_images_if_needed
    @article.images.purge if article_params[:avatar]
  end

  def update_article
    @article.update(article_params)
  end
end
