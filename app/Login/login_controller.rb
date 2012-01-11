require 'rho/rhocontroller'
require 'helpers/browser_helper'

class LoginController < Rho::RhoController
  include BrowserHelper

  #GET /Login
  def index
    $cookie == nil
    render :action => :index
  end

  # GET /Login/{1}
  def show
    $login = Login.find(@params['id'])
    if $login
      render :action => :show
    else
      redirect :action => :index
    end
  end

  # GET /Login/new
  def new
    $login = Login.new
    render :action => :new
  end

  # GET /Login/{1}/edit
  def edit
    @login = Login.find(@params['id'])
    if @login
      render :action => :edit
    else
      redirect :action => :index
    end
  end

  # POST /Login/create
  def create
    @login = Login.create(@params['login'])
    redirect :action => :index
  end

  # POST /Login/{1}/update
  def update
    @login = Login.find(@params['id'])
    @login.update_attributes(@params['login']) if @login
    redirect :action => :index
  end

  # POST /Login/{1}/delete
  def delete
    @login = Login.find(@params['id'])
    @login.destroy if @login
    redirect :action => :index
  end

  def reddit
    Rho::AsyncHttp.post(
        :url => "http://www.reddit.com/api/login",
        :body => "user=" + @params['user'] + "&passwd=" + @params['passwd'],
        :callback => url_for(:action => :loginCallback)
    )
    $user =  @params['user']
    render :action => :wait;
  end
  def wait
    render
  end

  def loginCallback
    $cookie= @params['cookies']
    WebView.navigate(url_for(:controller => :UserInfo, :action => :index))
    #

  end
  def profile
    $data = @params['body']
    #$linkKarma = @data['link_karma']
    #$commentKarma = @data['comment_karma']
    WebView.navigate(url_for(:action => :view_profile))
  end

end
