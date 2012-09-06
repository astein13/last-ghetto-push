class InvitationsController < ApplicationController

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender_id = current_user.id
    if @invitation.save
    Mailer.invitation(@invitation).deliver
      flash[:notice] = "Thank you, invitation sent."
      redirect_to root_url
    end
    
    
  end
  
end
