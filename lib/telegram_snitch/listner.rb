require 'sinatra/base'
require 'multi_json'
require_relative '../telegram_snitch'

module TelegramSnitch
  class Listner < Sinatra::Base
    post '/listen' do
      json = MultiJson.load(request.body.read, symbolize_keys: true)
      Base.logger.info("Receive request from: #{request.host}")

      Base.logger.info("Listner -- receive: #{json}")

      Base.redis.publish("activity", json[:message])
      204
    end
  end
end
