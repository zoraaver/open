class ConversationsController < ApplicationController
  before_action :authorize_user
  before_action :conversation_check, only: :create
  before_action :update_check, only: :update

  def index
    @conversations = current_user.conversations
  end

  def create
    @conversation = Conversation.new(conversation_params)

    @conv = current_user.conversations.find { |c|
      c.user_ids.sort == @conversation.user_ids.sort
    }

    if @conv
      @messages = @conv.messages
      redirect_to conversation_messages_path(@conv)
    else
      @conversation.save

      @messages = @conversation.messages
      redirect_to conversation_messages_path(@conversation)
    end
  end

  def update
    @conversation = Conversation.find(params[:id])

    UserConversation.create(user_id: params[:conversation][:user_ids], conversation_id: @conversation.id)

    redirect_to conversation_messages_path(@conversation)
  end

  def destroy
   @conversation= Conversation.find(params[:id])
   @conversation.destroy
   redirect_to conversations_path

  end 

  private

  def conversation_params
    params.permit(user_ids: [])
  end

  def conversation_check #checks user is the current user and other user is a friend
    user_ids = params[:user_ids].map { |e| e.to_i }
    friend = User.find(user_ids[1])

    if user_ids.length != 2
      redirect_to conversations_path
    elsif user_ids[0] != current_user.id
      flash[:notice] = "You are not authorized to perform this action."
      redirect_to conversations_path
    elsif !current_user.friend?(friend)
      flash[:notice] = "You are not friends with this person."
      redirect_to conversations_path
    end
  end

  def update_check
    new_user_id = params[:conversation][:user_ids].to_i

    new_user = User.find(new_user_id)

    if !current_user.friend?(new_user)
      flash[:notice] = "You are not friends with this person."
      redirect_to conversations_path
    end
  end
end
