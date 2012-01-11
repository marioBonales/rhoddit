require 'rho/rhocontroller'
require 'helpers/browser_helper'
require 'uri'

class SearchController < Rho::RhoController
  include BrowserHelper

  #GET /Search
  def index
    render
  end

  # GET /Search/{1}
  def show
    @search = Search.find(@params['id'])
    if @search
      render :action => :show
    else
      redirect :action => :index
    end
  end

  # GET /Search/new
  def new
    @search = Search.new
    render :action => :new
  end

  # GET /Search/{1}/edit
  def edit
    @search = Search.find(@params['id'])
    if @search
      render :action => :edit
    else
      redirect :action => :index
    end
  end

  # POST /Search/create
  def create
    @search = Search.create(@params['search'])
    redirect :action => :index
  end

  # POST /Search/{1}/update
  def update
    @search = Search.find(@params['id'])
    @search.update_attributes(@params['search']) if @search
    redirect :action => :index
  end

  # POST /Search/{1}/delete
  def delete
    @search = Search.find(@params['id'])
    @search.destroy if @search
    redirect :action => :index
  end

  def search
    searchfor = URI.encode(@params['searchTerms'])
    Rho::AsyncHttp.get(
        :url => "http://www.reddit.com/search/.json?q=#{searchfor}",
        :callback => url_for(:action => :search_callback)
    )
    render :action => :wait;
  end
  def wait
    render
  end

  def search_callback
    $stories = @params['body']
    WebView.navigate(url_for(:action => :index))
  end
end
