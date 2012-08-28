class MyboardController < ApplicationController
  def index
    @channels = Channel.all
    if session[:user_id]
      @invitations = current_user.invitations.upcoming(Time.zone.now + 7200)
      @created_fliers = current_user.created_fliers.upcoming(Time.zone.now + 7200)
      @added_fliers = current_user.added_fliers.upcoming(Time.zone.now + 7200)
      
      
    
    end
    if session[:organization_id]
      
      @created_fliers = current_user.created_fliers
    end
  end
  end






