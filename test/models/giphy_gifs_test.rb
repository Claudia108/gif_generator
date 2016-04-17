require 'test_helper'

class GiphyGifsTest < ActiveSupport::TestCase

  test "it can import an API" do
    data = GiphyGifs.new("http://api.giphy.com/v1/gifs/search?q=funny+cat&api_key=dc6zaTOxFJmzC")

    assert_equal "http://media3.giphy.com/media/QgcQLZa6glP2w/200w.gif", data.gif_urls[0]
    assert_equal "http://", data.gif_urls[0][0..6]
    assert_equal ".gif", data.gif_urls[0][-4..-1]
  end

end
