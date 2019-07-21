# frozen_string_literal: true

require_relative '../models/url_shortener'

def handler(event:, context:)
  code = event['pathParameters']['code']
  begin
    url = UrlShortener.find(id: code)
  rescue Aws::Record::Errors::NotFound => e
    puts e
    { statusCode: 404, body: 'URL not found' }
  rescue Aws::Record::Errors::RecordError => e
    puts e
    { statusCode: 500, body: 'Internal server error' }
  end

  { statusCode: 301, headers: { Location: url.long_url } }
end
