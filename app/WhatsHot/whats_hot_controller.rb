require 'rho/rhocontroller'
require 'helpers/browser_helper'

class WhatsHotController < Rho::RhoController
  include BrowserHelper

  #GET /WhatsHot
  def index
      redirect :action => :getStories
  end
  def getStories
    Rho::AsyncHttp.get(
        :url => "http://www.reddit.com/.json",
        :callback => url_for(:action => :storiesCallback)
    )
    render :action => :wait;
  end
  def wait
    render
  end

  def storiesCallback
    $stories= @params['body']
    WebView.navigate(url_for(:action => :stories))
  end

  def stories
    render
  end
  # GET /WhatsHot/{1}
  def show
    @whats_hot = WhatsHot.find(@params['id'])
    if @whats_hot
      render :action => :show
    else
      redirect :action => :index
    end
  end

  # GET /WhatsHot/new
  def new
    @whats_hot = WhatsHot.new
    render :action => :new
  end

  # GET /WhatsHot/{1}/edit
  def edit
    @whats_hot = WhatsHot.find(@params['id'])
    if @whats_hot
      render :action => :edit
    else
      redirect :action => :index
    end
  end

  # POST /WhatsHot/create
  def create
    @whats_hot = WhatsHot.create(@params['whats_hot'])
    redirect :action => :index
  end

  # POST /WhatsHot/{1}/update
  def update
    @whats_hot = WhatsHot.find(@params['id'])
    @whats_hot.update_attributes(@params['whats_hot']) if @whats_hot
    redirect :action => :index
  end

  # POST /WhatsHot/{1}/delete
  def delete
    @whats_hot = WhatsHot.find(@params['id'])
    @whats_hot.destroy if @whats_hot
    redirect :action => :index
  end
  
  def singleStory
	render
  end
end
