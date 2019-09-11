# slack_api_wrapper.rb
require "httparty"

class SlackApiError < StandardError; end

module SlackApi
  BASE_URL = "https://slack.com/api/"
  API_KEY = ENV["SLACK_TOKEN"]
  
  def self.send_msg(message, channel)
    
    response = HTTParty.post(
    "#{BASE_URL}/chat.postMessage",
    
    body:  {
    token: API_KEY,
    text: message,
    channel: channel},
    
    headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
    )
    
    unless response.code == 200 && response.parsed_response["ok"]
      raise SlackApiError, "Error when posting #{message} to #{channel}, error: #{response.parsed_response["error"]}"
    end
    
    return true
  end
end 
