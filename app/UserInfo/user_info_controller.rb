require 'rho/rhocontroller'
require 'helpers/browser_helper'

class UserInfoController < Rho::RhoController
  include BrowserHelper

  #GET /UserInfo
  def index
    Rho::AsyncHttp.get(
        :url => "http://www.reddit.com/user/#{$user}/about.json",
        :callback => url_for(:action => :profile)
    )
    render :action => :wait
  end
  def profile
    $data = @params['body']
    #$linkKarma = @data['link_karma']
    #$commentKarma = @data['comment_karma']
    WebView.navigate(url_for(:action => :view_profile))
  end
  def view_profile
    render
  end
  def wait
    render
  end
  # GET /UserInfo/{1}
  def show
    @user_info = UserInfo.find(@params['id'])
    if @user_info
      render :action => :show
    else
      redirect :action => :index
    end
  end

  # GET /UserInfo/new
  def new
    @user_info = UserInfo.new
    render :action => :new
  end

  # GET /UserInfo/{1}/edit
  def edit
    @user_info = UserInfo.find(@params['id'])
    if @user_info
      render :action => :edit
    else
      redirect :action => :index
    end
  end

  # POST /UserInfo/create
  def create
    @user_info = UserInfo.create(@params['user_info'])
    redirect :action => :index
  end

  # POST /UserInfo/{1}/update
  def update
    @user_info = UserInfo.find(@params['id'])
    @user_info.update_attributes(@params['user_info']) if @user_info
    redirect :action => :index
  end

  # POST /UserInfo/{1}/delete
  def delete
    @user_info = UserInfo.find(@params['id'])
    @user_info.destroy if @user_info
    redirect :action => :index
  end
end
