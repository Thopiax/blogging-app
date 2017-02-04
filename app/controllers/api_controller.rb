require 'net/http'
require 'json'

class ApiController < ApplicationController
  API_KEY = '7306f2408fe74ed1a93130ed418784b0'.freeze
  API_ENDPOINT_SENTIMENT = 'https://westus.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment'.freeze
  API_ENDPOINT_KEYWORDS = 'https://westus.api.cognitive.microsoft.com/text/analytics/v2.0/keyphrases'.freeze

  def analyze_text
    # Analyze sentiment
    # Analyze keywords
    # Convert keywords into images
    # Convert text into emojis
    # Return json with list of images, list of emojis, sentiment
    render :json => get_keywords('i went to imperial college london today to study computer science')
  end

  private

  def get_sentiment(txt)
    uri = URI(API_ENDPOINT_SENTIMENT)
    uri.query = URI.encode_www_form({})

    request = Net::HTTP::Post.new(uri.request_uri)
    request['Content-Type'] = 'application/json'
    request['Ocp-Apim-Subscription-Key'] = API_KEY
    request.body = {
      documents: [{
        language: 'en',
        id: '0',
        text: txt
      }]
    }.to_json

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end

    result = JSON.parse(response.body)
    result['documents'][0]['score']
  end

  def get_keywords(txt)
    uri = URI(API_ENDPOINT_KEYWORDS)
    uri.query = URI.encode_www_form({})

    request = Net::HTTP::Post.new(uri.request_uri)
    request['Content-Type'] = 'application/json'
    request['Ocp-Apim-Subscription-Key'] = API_KEY
    request.body = {
      documents: [{
        language: 'en',
        id: '0',
        text: txt
      }]
    }.to_json

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end

    result = JSON.parse(response.body)
    result['documents'][0]['keyPhrases']
  end
end
