require 'bundler/setup'
require 'redis'
require 'logger'
require 'telegram/bot'
require 'dotenv'
Dotenv.load

module TelegramSnitch
  class Base
    class << self
      def redis
	$redis ||= Redis.new(timeout: 0)
      end

      def logger
	$logger ||= Logger.new(File.expand_path("../../log/telegram_snitch.log", __FILE__), 'weekly')
      end

      def telegram_bot
	$telegram_bot ||= Telegram::Bot::Client.new(ENV['BOT_TOKEN'], logger: logger)
      end
    end
  end
end
