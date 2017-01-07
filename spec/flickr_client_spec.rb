require "rspec"
require_relative "../flickr_client"

describe FlickrClient do
  let(:client) { FlickrClient.new }
  let(:response) do
    {"photos"=>
     {"page"=>1,
      "pages"=>1,
      "perpage"=>100,
      "total"=>"74",
      "photo"=>
         [{"id"=>"id1", "owner"=>"ownerid", "secret"=>"secret1", "server"=>"server", "farm"=>4,
           "title"=>"title1", "ispublic"=>1, "isfriend"=>0, "isfamily"=>0},
          {"id"=>"id2", "owner"=>"ownerid", "secret"=>"secret2", "server"=>"server", "farm"=>4,
           "title"=>"title2", "ispublic"=>1, "isfriend"=>0, "isfamily"=>0}]
      }
    }.to_json

  end

  before do
    allow(Net::HTTP).to receive(:get).and_return(response)
  end

  it "gets the image urls" do
    expect(client.get_photo_urls).to include "https://farm4.staticflickr.com/server/id1_secret1.jpg"
  end
end
