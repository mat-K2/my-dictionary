require "scrapinger"

class BrowseController < ApplicationController
  layout false, :only => %w(home)

  def index
    @iframe_url = params[:url] || "/browse/home"
    @search_result = Scrapinger.search(params[:word]) if params[:word]
  end
end
