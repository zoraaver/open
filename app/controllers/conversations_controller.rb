class ConversationsController < ApplicationController
  before_action :authenticate_user

  def index
    @conversations = current_user.conversations
  end

  def create
    @conversation = Conversation.new(conversation_params)

    @conv = Conversation.all.find { |c|
      c.user_ids.sort == @conversation.user_ids.sort
    }
    if @conv != nil
      @messages = @conv.messages
      redirect_to conversation_messages_path(@conv)
    else
      @conversation.save

      @messages = @conversation.messages
      redirect_to conversation_messages_path(@conversation)
    end
  end

  def update
    new_user_id = params[:conversation][:user_ids].to_i

    @conversation = Conversation.find(params[:id])

    UserConversation.create(user_id: new_user_id, conversation_id: @conversation.id)

    redirect_to conversation_messages_path(@conversation)
  end

  private

  def conversation_params
    params.permit(user_ids: [])
  end
end
