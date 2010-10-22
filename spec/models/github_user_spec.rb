require 'spec_helper'

describe GithubUser do
  before(:each) do
    @valid_attributes = {
      :username => "value for username",
      :followers => 1,
      :forks => 1
    }
  end

  it "should create a new instance given valid attributes" do
    GithubUser.create!(@valid_attributes)
  end
end
