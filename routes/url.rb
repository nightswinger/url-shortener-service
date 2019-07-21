# frozen_string_literal: true

# require 'hashids'
require_relative '../models/url_shortener'
require 'aws-record'
require 'hashids'

def handler(event:, context:)
  data = JSON.parse(event['body'])

  # Check whether longUrl is valid
  url = UrlShortener.new
  url.long_url = data['longUrl']

  return { statusCode: 401, body: 'Invalid long url' } unless url.valid?

  # Create url code
  now = Time.now

  hashids = Hashids.new(ENV['HASHIDS_SALT'])
  hash = hashids.encode(now.to_i, now.usec)

  base_url = ENV['BASE_URL'] || "https://#{event['headers']['Host']}/#{event['requestContext']['stage']}"
  url.id = hash
  url.short_url = "#{base_url}/#{url.id}"
  url.date = now.to_s

  begin
    url.save
  rescue Aws::Record::Errors::RecordError => e
    puts e
    { statusCode: 500, body: e }
  end

  { statusCode: 200, body: url.short_url }
end
