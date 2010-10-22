require 'spec_helper'

describe LastfmUser do
  before(:each) do
    @valid_attributes = {
      :username => "value for username",
      :country => "value for country",
      :real_name => "value for real_name",
      :age => 1,
      :verified => false
    }
  end

  it "should create a new instance given valid attributes" do
    LastfmUser.create!(@valid_attributes)
  end
end
