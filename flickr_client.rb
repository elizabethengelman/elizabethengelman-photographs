require 'json'

class FlickrClient
  API_KEY = ENV["FLICKR_API_KEY"]
  USER_ID = ENV["FLICKR_USER_ID"]

  FLICKR_API_URL = "https://api.flickr.com/services/rest/?method=flickr.people.getPublicPhotos&api_key=#{API_KEY}&format=json&nojsoncallback=1&user_id=#{USER_ID}";

  def get_photo_urls
    photos = JSON.parse(fetch_photos)["photos"]["photo"]
    photos.map do |photo|
      construct_image_url(photo)
    end.to_json
  end

  private

  def fetch_photos
    uri = URI(FLICKR_API_URL)
    Net::HTTP.get(uri)
  end

  def construct_image_url(photo)
    "https://farm#{photo["farm"]}.staticflickr.com/#{photo["server"]}/#{photo["id"]}_#{photo["secret"]}.jpg"
  end
end
