class Admin::GifsController < Admin::BaseController
  def new
    @category = Category.last
    @gifs = Gif.new
    @potential_gifs = GiphyGifs.new(Category.find(params[:category_id]).name).gif_urls
  end

  def create
    save_gifs(get_urls)
    redirect_to admin_category_path(params[:category_id])
  end

  private

  def get_urls
    urls = []
    1.upto(25) do |num|
      urls << params["#{num}"]
    end
    urls.compact
  end

  def save_gifs(urls)
    urls.each do |url|
      Gif.create(image_path: url, category_id: params[:category_id])
    end
  end
end
