
class FliersController < ApplicationController
  before_filter :can_view_flier?, :only => "show"
  

  def show
    @flier = Flier.find_by_id(params[:id])
    @channels = Channel.all
  end

  def new
    @flier = Flier.new
    @channels = Channel.all
  end
  
  def create
     @channels = Channel.all
     @flier = params[:flier]
     @time = params[:flier][:start_time]
     @flier['start_time'] = Chronic.parse(@time)
     @flier = Flier.create!(@flier)
     @users = User.find_all_by_community_id(current_user.community_id)

    #create organization
    if session[:organization_id]
    @organizations = Organization.find_all_by_community_id(current_user.community_id)
    end

    #create myfliers for each user in the community
     @users.each do |user|
      @myflier = Myflier.create!(:user_id => user.id, :flier_id => @flier.id, :attending_status => nil, :myscore => 100)
     end
    

    #if user is a person....
     if session[:user_id]
      @creator_myflier = Myflier.find_by_user_id_and_flier_id(current_user.id, @flier.id)
      @creator_myflier.update_attribute(:attending_status, '9')
      redirect_to :controller => :myfliers, :action => :invite, :flier_id => @flier.id
     end

    #if user is an organization
    if session[:organization_id]
      @creator_organizationflier = OrganizationFlier.create!(:organization_id => current_user.id, :flier_id=>@flier.id, :attending_status => '9')
    end

  end
  
  def edit
    @flier = Flier.find_by_id(params[:flier_id])
    @flier.start_time = @flier.start_time.in_time_zone(current_user.timezone).strftime('%m/%d/%Y @ %l:%M %p')
    @creator_id = @flier.creator_id.to_i
    @channels = Channel.all
   
    unless @creator_id==current_user.id
      redirect_to :controller => "error_pages", :action => "not_your_flier"
    else
     
    end
  end
  def update
         @new_flier = params[:flier]
         @new_flier['start_time'] = Chronic.parse(params[:flier][:start_time])
         @flier = Flier.find(params[:id])
      if @flier.update_attributes!(@new_flier)
      redirect_to :controller => 'fliers', :action => 'show', :id => params[:id]
      end
  end

  def destroy
    @channels = Channel.all
    @flier = Flier.find_by_id(params[:flier_id])
    @creator_id = @flier.creator_id.to_i
    unless @creator_id == current_user.id
      redirect_to :controller => "error_pages", :action => "not_your_flier"
    else
    
    @flier.destroy
      redirect_to(myboard_path)
    end
  end
end
