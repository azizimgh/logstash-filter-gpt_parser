Gem::Specification.new do |s|
    s.name          = 'logstash-filter-gpt_parser'
    s.version       = '1.1.0'
    s.licenses      = ['Apache-2.0']
    s.summary       = "Logstash filter plugin to extract ECS fields using ChatGPT API"
    s.description   = "A Logstash plugin that leverages OpenAI's ChatGPT to parse log lines and extract ECS-compliant fields."
    s.homepage      = "https://github.com/azizimgh/logstash-filter-gpt_parser"
  
    s.authors       = ['']
    s.email         = ''
    s.require_paths = ['lib']
  
    # Files
    s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','CONTRIBUTORS','Gemfile','LICENSE','NOTICE.TXT']
     # Tests
    s.test_files = s.files.grep(%r{^(test|spec|features)/})
  
    # Special flag to let us know this is actually a logstash plugin
    s.metadata = { "logstash_plugin" => "true", "logstash_group" => "filter" }
  
    # Gem dependencies
    s.add_runtime_dependency "logstash-core-plugin-api", "~> 2.0"
    s.add_development_dependency 'logstash-devutils'
  end
  