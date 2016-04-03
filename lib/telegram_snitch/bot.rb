require_relative '../telegram_snitch'

module TelegramSnitch
  class Bot < Base
    class << self
      HELP = <<HELP
Snitch bot for notifications.
Available commands:
  /start - Start 
  /help  - Show hint
Support: shindu666@gmail.com
HELP
      def run!
	logger.info " -> Start Snitch bot instance"
	telegram_bot.run do |bot|
	  bot.listen do |m|
	    chat_id = m.chat.id
	    case m.text
	    when %r{^\/help}
	      bot.api.sendMessage(chat_id: chat_id, text: HELP, disable_web_page_preview: true)
	    when %r{^\/start}
	      redis.set "channel:activity", chat_id

	      bot.api.sendMessage(chat_id: chat_id, text: "Hello! I snitch and I'm ready to track your notifications.")
	    when %r{^\/stop}
	      redis.set "channel:activity", nil
	      
	      bot.api.sendMessage(chat_id: chat_id, text: "I snitch and I'm stop track your notifications.")
	    else
	      bot.api.sendMessage(chat_id: chat_id, text: "Command `#{m.text}` not found.")
	    end
	  end
	end
      end
    end
  end
end
