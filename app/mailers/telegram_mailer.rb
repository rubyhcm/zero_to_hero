class TelegramMailer < ApplicationMailer
  def send_group_message(message)
    HTTParty.post("https://api.telegram.org/#{ENV['BOT_TOKEN']}/sendMessage",
                  headers: {
                    'Content-Type' => 'application/json'
                  },
                  body: {
                    chat_id: ENV['CHAT_ID'],
                    text: message
                  }.to_json)
  end
end
