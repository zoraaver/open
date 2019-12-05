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

  private

  def conversation_params
    params.permit(user_ids: [])
  end
end
