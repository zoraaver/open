class ConversationsController < ApplicationController
  before_action :authenticate_user

  def index
    @conversations = current_user.conversations
  end

  def create
    
    @conversation = Conversation.create(conversation_params)
    @messages = @conversation.messages
    redirect_to conversation_messages_path(@conversation)
  end

  def update
    new_user_id = params[:conversation][:user_ids].to_i
    
    @conversation = Conversation.find(params[:id])

    UserConversation.create(user_id: new_user_id, conversation_id: @conversation.id)

    redirect_to conversation_messages_path(@conversation)
  end

  private

  def conversation_params
    params.permit(user_ids:[])
  end

  
end
