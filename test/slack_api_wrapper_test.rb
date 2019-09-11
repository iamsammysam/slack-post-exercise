# slack_api_wrapper_test.rb
require_relative 'test_helper'

describe SlackApi do
  it "can send a valid message" do
    VCR.use_cassette("slack-posts") do
      response = SlackApi.send_msg("Hey I can post messages!", "random")
      expect(response).must_equal true
    end
  end
  
  it "will raise an error when given an invalid channel" do
    VCR.use_cassette("slack-posts") do
      exception = expect {
      SlackApi.send_msg("This post should not work", "invalid-channel")
    }.must_raise SlackApiError
    
    expect(exception.message).must_equal 'Error when posting This post should not work to invalid-channel, error: channel_not_found'
  end
end
end 
