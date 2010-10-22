require 'spec_helper'

describe Artist do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :image_url => "value for image_url",
      :lastfm_url => "value for lastfm_url"
    }
  end

  it "should create a new instance given valid attributes" do
    Artist.create!(@valid_attributes)
  end
end
