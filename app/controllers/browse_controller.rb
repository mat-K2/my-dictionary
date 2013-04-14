class BrowseController < ApplicationController
  def index
    @iframe_url = params[:url] || "/browse/home"
  end
end
