require 'net/http'
require 'json'
require 'color'

class ApiController < ApplicationController
  API_KEY = '7306f2408fe74ed1a93130ed418784b0'.freeze
  API_ENDPOINT_SENTIMENT = 'https://westus.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment'.freeze
  API_ENDPOINT_KEYWORDS = 'https://westus.api.cognitive.microsoft.com/text/analytics/v2.0/keyphrases'.freeze

  def analyze_text
    txt = params[:txt]
    # Analyze keywords and sentiment
    sentiment = get_sentiment txt
    keywords = get_keywords txt
    emojis = get_emojis txt
    sentiment_colour = get_sentiment_colour sentiment
    sentiment_emoji = get_sentiment_emoji sentiment

    # Convert keywords into images
    number_of_images = 5
    images = []
    keywords.each do |keyword|
      images.push(get_images(keyword, number_of_images))
    end

    result = {
      keywords: keywords,
      sentiment: sentiment,
      sentimentColour: sentiment_colour,
      images: images,
    }

    render :json => result
  end

  private
  def get_sentiment_colour sentiment
    hue = sentiment * 120
    saturation = 50
    lightness = 50
    color = Color::HSL.new(hue, saturation, lightness)
    color.html
  end

  def get_sentiment_emoji sentiment

  end

  def get_emojis txt
  end

  def get_images(keyword, number_of_images)
    results = GoogleCustomSearchApi.search(keyword, limit: number_of_images, searchType: "image")
    images = []
    results["items"].each do |item|
      images << item["link"]
    end
    return images
  end

  def get_sentiment(txt)
    result = send_request(API_ENDPOINT_SENTIMENT, txt)
    result['documents'][0]['score']
  end

  def get_keywords(txt)
    result = send_request(API_ENDPOINT_KEYWORDS, txt)
    result['documents'][0]['keyPhrases']
  end

  def send_request(endpoint, txt)
    uri = URI(endpoint)
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

    JSON.parse(response.body)
  end
end
