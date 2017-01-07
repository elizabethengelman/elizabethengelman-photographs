require 'sinatra'
require 'net/http'
require './flickr_client'

get '/flickr_photos' do
  headers 'Access-Control-Allow-Origin' => '*'
  headers 'Access-Control-Allow-Method' => 'GET'
  FlickrClient.new.get_photo_urls
end
