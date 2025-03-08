
# logstash-filter-gpt_parser

`logstash-filter-gpt_parser` is a Logstash filter plugin that integrates with OpenAI's GPT model to parse and process logs, enabling advanced natural language processing (NLP) for log data. This filter allows users to analyze and parse unstructured log data efficiently, helping teams automate the extraction of meaningful insights from logs in real-time.

## Features

- Parse unstructured log data using GPT models.
- Generate structured insights from raw logs.
- Support for a variety of log formats.
- Flexible configuration for use with Logstash pipelines.
- Simple integration with Logstash setups for real-time log processing.

## Requirements

- [Logstash](https://www.elastic.co/logstash/) version 7.x or higher.
- An OpenAI API key to interact with the GPT model.
- Ruby (for building the plugin gem).

## Installation

### Installing via Logstash Plugin Manager

```bash
bin/logstash-plugin install logstash-filter-gpt_parser
```

### Building the Plugin Gem

1. Clone the repository:

   ```bash
   git clone https://github.com/azizimgh/logstash-filter-gpt_parser.git
   ```

2. Navigate to the plugin directory:

   ```bash
   cd logstash-filter-gpt_parser
   ```

3. Build the gem:

   ```bash
   gem build logstash-filter-gpt_parser.gemspec
   ```

4. Install the plugin:

   ```bash
   bin/logstash-plugin install logstash-filter-gpt_parser-*.gem
   ```

## Configuration

Add the following configuration to your Logstash pipeline configuration file:

```plaintext
filter {
  gpt_parser {
    api_key => "your_openai_api_key"
    model   => "gpt-3.5-turbo"  # Or another model of your choice
    field   => "message"  # Field containing the log message to be parsed
  }
}
```

- `api_key`: Your OpenAI API key for accessing GPT models.
- `model`: The GPT model you want to use (e.g., `gpt-3.5-turbo`).
- `field`: The field in the log data to be parsed by GPT.

## Usage

This plugin processes the log data specified in the `field` parameter. The GPT model parses the content and provides structured insights or additional context based on the unstructured data. The results will be added to the Logstash event as new fields for further processing or output.

## Example Log Entry

Before processing (unstructured log):

```json
{
  "message": "66.249.65.62 - - [06/Nov/2014:19:12:14 +0600] \"GET /?q=%E0%A6%A6%E0%A7%8B%E0%A7%9F%E0%A6%BE HTTP/1.1\" 200 4356 \"-\" \"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)\""
"
}
```

After processing (structured log):

```json
{
  "client": {
    "ip": "66.249.65.62"
  },
  "timestamp": "2014-11-06T19:12:14.000Z",
  "http": {
    "request": {
      "method": "GET",
      "bytes": 4356,
      "body": {
        "content": "/?q=%E0%A6%A6%E0%A7%8B%E0%A7%9F%E0%A6%BE"
      },
      "http_version": "1.1"
    },
    "response": {
      "status_code": 200
    }
  },
  "url": {
    "original": "/?q=%E0%A6%A6%E0%A7%8B%E0%A7%9F%E0%A6%BE"
  },
  "user_agent": {
    "original": "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"
  },
  "event": {
    "original": "66.249.65.62 - - [06/Nov/2014:19:12:14 +0600] \"GET /?q=%E0%A6%A6%E0%A7%8B%E0%A7%9F%E0%A6%BE HTTP/1.1\" 200 4356 \"-\" \"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)\""
  },
  "message": "66.249.65.62 - - [06/Nov/2014:19:12:14 +0600] \"GET /?q=%E0%A6%A6%E0%A7%8B%E0%A7%9F%E0%A6%BE HTTP/1.1\" 200 4356 \"-\" \"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)\""

}

```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Feel free to submit issues, pull requests, or suggestions. Contributions are welcome!