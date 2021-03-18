class SendController < ApplicationController
  require 'httpclient'
  require 'json'
  def new
    
  end
  
  def create
    url = 'https://fcm.googleapis.com/fcm/send'
    client = HTTPClient.new
    header = {
      "Authorization": "key=#{ENV['AUTH_KEY']}",
      "Content-Type": 'application/json',
      'project_id': "key=#{ENV['PROJECT_ID']}"
    }
    body = {
      to: ENV['DEVICE_ID'],
      notification: {
        title: params[:title],
        body: params[:content]
      }
    }.to_json
    if html = client.post(url, header: header, body: body)
      flash[:notice] = 'プッシュ通知を送信しました。'
      redirect_to :new_send
    end
  end
end
