require "logstash/filters/base"
require "logstash/namespace"
require "net/http"
require "uri"
require "json"

class LogStash::Filters::ChatGPT < LogStash::Filters::Base
  config_name "gpt_parser"

  # API Configuration
  config :api_url, :validate => :string, :default => "https://api.openai.com/v1/chat/completions"
  config :api_key, :validate => :string, :required => true
  config :log_field, :validate => :string, :default => "message"

  public
  def register
    # Any initialization goes here
  end

  public
  def filter(event)
    log_line = event.get(@log_field)
    return unless log_line

    uri = URI(@api_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.path, {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{@api_key}"
    })

    prompt = "Parse this log line and extract fields from it so that they can be ECS compliant, output only json: #{log_line}"

    request.body = {
      model: "gpt-4",
      messages: [{ role: "user", content: prompt }],
      max_tokens: 200
    }.to_json

    response = http.request(request)
    parsed_response = JSON.parse(response.body) rescue {}

    if parsed_response["choices"]
      json_output = parsed_response["choices"][0]["message"]["content"] rescue nil
      if json_output
        begin
          parsed_json_output = JSON.parse(json_output)
        rescue JSON::ParserError
          parsed_json_output = json_output
        end
        event.set("chatgpt_output", parsed_json_output)
      end
    end

    filter_matched(event)
  end
end


