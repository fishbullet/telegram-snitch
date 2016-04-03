# TelegramSnitch

Setup the `BOT_TOKEN` in the `.env` file.

Based on: [TelegramBotRuby](https://github.com/atipugin/telegram-bot-ruby)

## Installation

Execute:

    $ bundle install

## Usage

Run the bot: 

    $ bundle exec bin/bot

Run the listner:

    $ bundle exec thin start

Run the publisher:

    $ bundle exec bin/publisher

Sent custom notification with pauload:

    $ curl -X POST -d '{ "object": { "message": "fucking awesome notifications" } }' http://www.listner_app_host/listen

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fishbullet/telegram-snitch. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

