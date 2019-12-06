class MessagesController < ApplicationController

  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  before_action :authorize_user
  before_action :privacy_check
  before_action :set_user, only: :create
  before_action :user_check, only: :create

  def index
    
    @conversation.mark_messages_as_read(current_user)
    @messages = @conversation.messages
    
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end

    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end

    @message = @conversation.messages.new
    
  end

  def create
    @message = @conversation.messages.new(message_params)
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :user_id)
  end

  def privacy_check #checks current user is a participant of the requested conversation
    
    if !@conversation.user_ids.include?(current_user.id)
      flash[:notice] = "You are not authorized for this action"
      redirect_to conversations_path
    end
  end

  def set_user
    @user = User.find(params[:message][:user_id])
  end
  
end
