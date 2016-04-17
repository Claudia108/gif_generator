require 'faraday'

class GiphyGifs
  def initialize(category_name)
    api = Faraday.get("http://api.giphy.com/v1/gifs/search?q=#{category_name}&api_key=dc6zaTOxFJmzC&limit=80")
    raw_data = api.body
    @gif_data = JSON.parse(raw_data)
  end

  def gif_urls
    gifs = @gif_data["data"]
    urls = gifs.map do |gif|
      gif["images"]["fixed_width"]["url"]
    end
  end


end
