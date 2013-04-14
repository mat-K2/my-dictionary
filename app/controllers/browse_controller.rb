require "scrapinger"

class BrowseController < ApplicationController
  layout false, :only => %w(home)

  def index
    @iframe_url = params[:url] || "/browse/home"
    @search_result = Scrapinger.search(params[:word]) if params[:word]
    respond_to do |format|
      format.html
      format.js
    end
  end
end
