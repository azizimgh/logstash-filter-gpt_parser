# encoding: utf-8
require_relative '../spec_helper'
require "logstash/filters/gpt_parser"

describe LogStash::Filters::LlmParser do
  describe "Set to Hello World" do
    let(:config) do <<-CONFIG
      filter {
        gpt_parser {
          message => "Hello World"
        }
      }
    CONFIG
    end

    sample("message" => "some text") do
      expect(subject).to include("message")
      expect(subject.get('message')).to eq('Hello World')
    end
  end
end
