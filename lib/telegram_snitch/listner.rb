require 'sinatra/base'
require 'multi_json'
require_relative '../telegram_snitch'

module TelegramSnitch
  class Listner < Sinatra::Base
    post '/listen' do
      json = MultiJson.load(request.body.read, symbolize_keys: true)

      Base.logger.info("Listner -- receive: #{json}")
      payload = {}
      payload[:message] = if json && json[:payload]
			    "CircleCI notice about build: ##{json[:payload][:build_num]} status: #{json[:payload][:status]}"
			  elsif json && json[:repository]
			    "Github notice #{json[:repository][:name]} updated by #{json[:sender][:login]}"
			  elsif json && json[:object]
			    "Custom notification received: #{json[:object][:message]}"
			  else
			    nil
			  end

      if payload[:message]
	Base.redis.publish("activity", payload[:message])
      end
      204
    end
  end
end
