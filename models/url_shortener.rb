# frozen_string_literal: true

require 'aws-record'

class UrlShortener
  include Aws::Record

  set_table_name ENV['DYNAMODB_TABLE']

  string_attr :id, hash_key: true
  string_attr :short_url
  string_attr :long_url
  string_attr :date

  # Check url valid
  def valid?
    url = begin
            URI.parse(long_url)
          rescue StandardError
            false
          end
    url.is_a?(URI::HTTP) || url.is_a?(URI::HTTPS)
  end
end
