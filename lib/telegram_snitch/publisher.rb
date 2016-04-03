require_relative '../telegram_snitch'

module TelegramSnitch
  class Publisher < Base
    class << self
      def run!
	logger.info " -> Start Snitch bot publisher instance"
	redis.psubscribe "activity" do |on|
	  on.psubscribe do |channel, _|
	    logger.info "Publisher -- Subscribed to ##{channel}"
	  end

	  on.pmessage do |_, channel, message|
	    logger.info "Publisher -- Message received \"#{message}\" from the channel ##{channel}"

	    chat_id = Redis.new.get("channel:#{channel}")

	    if chat_id && !chat_id.empty?
	      telegram_bot.api.sendMessage(chat_id: chat_id, text: message)
	    end
	  end
	end
      end
    end
  end
end
