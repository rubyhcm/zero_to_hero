class TelegramsController < ApplicationController
  skip_before_action :authenticate_user!
  # GET /telegrams or /telegrams.json
  def index
    res = HTTParty.get("https://api.telegram.org/#{ENV['BOT_TOKEN']}/getChat?chat_id=#{ENV['CHAT_ID']}")
    @title = res['result']['title']
    @id = res['result']['id']
  end

  def group_message
    HTTParty.post("https://api.telegram.org/#{ENV['BOT_TOKEN']}/sendMessage",
                  headers: {
                    'Content-Type' => 'application/json'
                  },
                  body: {
                    chat_id: ENV['CHAT_ID'],
                    text: params[:message]
                  }.to_json)

    redirect_to root_path, notice: 'success'
  end
end
