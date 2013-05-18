# -*- coding: utf-8 -*-
class AuthController < ApplicationController
  skip_before_filter :simple_authenticate_user
  def ripple
    reset_session

    rsp = Faraday.new(:url => 'http://ripple-web.herokuapp.com').post '/api/oauth' do |req|
      req.body = {
        :consumer_key => "lE1VJxvaRGB8dTMseQNF",
        :consumer_secret => "fZ5O7dv6WJ3KFQH0rnxcCbEBhLRU81yGjpikuz29"
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
