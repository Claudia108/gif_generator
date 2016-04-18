class FavoritesController < ApplicationController
  def new
    @favorites = Favorite.new
    @categories = Category.all
  end

  def create
    create_favorites
    redirect_to favorites_path
  end

  def index
    @favorites = Favorite.all
  end

  def destroy
    Favorite.find(params[:id]).destroy
    redirect_to favorites_path
  end

  private

  def create_favorites
    favorited_urls = get_favorited_urls
    favorited_gifs = get_favorited_gifs(favorited_urls)
    favorited_gifs.each do |gif|
      sha = Digest::SHA1.hexdigest("#{gif.image_path}#{current_user.username}")
      Favorite.create(gif_id: gif.id, user_id: current_user.id, sha: sha)
    end
  end

  def get_favorited_urls
    categories    = Category.all
    favorite_gifs = []
    categories.each do |category|
      1.upto(category.gifs.count) do |num|
        favorite_gifs << params["#{category.name}#{num}"]
      end
    end
    favorite_gifs.compact
  end

  def get_favorited_gifs(favorited_urls)
    favorited_urls.map do |url|
      Gif.find_by(image_path: url)
    end
  end
end
