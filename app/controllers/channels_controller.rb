class ChannelsController < ApplicationController
  def index
    @channels = Channel.all
    @channel = Channel.find_by_id(params[:channel_id])
    @community = Community.find_by_id(current_user.community_id)
    @channel_name = @channel.channel
    @fliers_for_channel = current_user.channel_fliers(params[:channel_id], current_user.community_id, '1')


    
  end
end
