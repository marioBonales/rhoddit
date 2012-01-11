require 'rho/rhoapplication'

class AppApplication < Rho::RhoApplication
  def initialize
    # Tab items are loaded left->right, @tabs[0] is leftmost tab in the tab-bar
    # Super must be called *after* settings @tabs!
    @tabs = [
	{:label => 'Login', :action => '/app/Login', :icon => '/public/images/tab_images/login_tab_icon.png'},
	{:label => "what's hot", :action => 'app/WhatsHot', :icon => '/public/images/tab_images/whats_hot_icon.png'},
	{:label => 'Search', :action => 'app/Search', :icon => 'public/images/tab_images/new_storie_icon.png'},
	{:label => 'User Status', :action => 'app/UserInfo', :icon => 'public/images/tab_images/user_tab_icon.png'},
	]
    #To remove default toolbar uncomment next line:
	@@toolbar = nil
    super

    # Uncomment to set sync notification callback to /app/Settings/sync_notify.
    # SyncEngine::set_objectnotify_url("/app/Settings/sync_notify")
    # SyncEngine.set_notification(-1, "/app/Settings/sync_notify", '')
  end
end
