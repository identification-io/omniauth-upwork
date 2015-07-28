# OmniAuth Upwork

Simple gem to deal with titles and meta tags for Rails 3+.

## Installation

Add this line to your application's Gemfile:

    gem "omniauth-github-oauth", "~> 1.0"

And then execute:

    $ bundle

## Usage

    use OmniAuth::Builder do
      provider :upwork, ENV['UPWORK_KEY'], ENV['UPWORK_SECRET']
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
