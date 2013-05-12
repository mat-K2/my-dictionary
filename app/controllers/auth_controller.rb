# -*- coding: utf-8 -*-
class AuthController < ApplicationController
  skip_before_filter :simple_authenticate_user
  def ripple
    reset_session

    rsp = Faraday.new(:url => 'http://localhost:3000').post '/api/oauth' do |req|
      req.body = {
        :consumer_key => "EKXgpGZUnhFiILPsM53Wl",
        :consumer_secret => "kOMP2VDa5wnz1v0pRL8TXhuAjsegHbym9qQJdB4UF"
      }
    end
    auth = JSON.parse(rsp.body)
    if authentication = Authentication.find_by_provider_and_uid(auth['provider'], params[:uid])
      user = authentication.user
      session[:user_id] = user.id
      redirect_to root_path
    else
      user = User.new(:email => "test#{params[:uid]}@example.com", :password => [*0..9, *'a'..'z', *'A'..'Z'].sample(8).join)
      user.authentication = Authentication.new(:provider => auth['provider'], :uid => params[:uid])
      if user.save
        session[:user_id] = user.id
        redirect_to root_path
      else
        render :text => "ユーザ作成に失敗しました"
      end
    end
  end
end
