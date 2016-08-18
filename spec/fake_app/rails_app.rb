# require 'rails/all'
require 'action_controller/railtie'
require 'action_view/railtie'

require 'fake_app/active_record/config' if defined? ActiveRecord

# config
app = Class.new(Rails::Application)
app.config.secret_key_base = app.config.secret_token = 'sd57djud4e8444053437c36cc66c4'
app.config.session_store :cookie_store, :key => '_myapp_session'
app.config.x.xmpp_password = 'dfghfd4dfhdf5j'
app.config.active_support.deprecation = :log
app.config.eager_load = false
# Rails.root
app.config.root = File.dirname(__FILE__)
Rails.backtrace_cleaner.remove_silencers!
app.initialize!

# routes
app.routes.draw do
  resources :users
  resources :events
end

#models
require 'fake_app/active_record/models' if defined? ActiveRecord

# controllers
class ApplicationController < ActionController::Base
  def current_user
    User.last
  end
end

class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    render :inline => <<-ERB

<!-- A couple of points to note:
1) We use current_user's DB id, but you could use any other id that represents the user uniquely
2) In this fake app we use the same password for all users. Don't do that in real app
3) We use current event's id as the room id, since in this fake app we want to let users who attend the same event
to chat among themselves
 -->
<%= include_converse_with_me(current_user.id,
                             current_user.name,
                             Rails.configuration.x.xmpp_server,
                              @event.id) %>
    ERB
  end
end

# helpers
Object.const_set(:ApplicationHelper, Module.new)