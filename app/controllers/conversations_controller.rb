class ConversationsController < ApplicationController
  before_filter :authenticate_user!

  # layout false

  def index
#    @decorated_conversation = ConversationDecorator.new(current_user) add avatar if you want
#
#    if current_user.admin?
#      redirect_to(user/admin page)
#      this page has problematic conversation
#      also list volunteers/admins ( link to /admin/edit/user/:id )
#      and add also other volunteer
#    elsif current_user.volunteer?
#       route to conversations/volunteer ( volunteer waiting page )
#       have additional
#    elseif current_user.survivor?
#     load balance volunteers and assign if possible
#     volunteer = find available User that are online and have volunteer role status.
#     volunteer is always the recipient
#     if none
#      redirect to page saying no available volunteers
#     else
#      redirect_to(conversations_path(:sender_id => current_user.id, :recipient_id => user.id)
#      you
#    end
  end

  def create
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end

    redirect_to conversation_path(@conversation)
  end

  def show
    @users = User.all
    @conversation = Conversation.find(params[:id])
    @reciever = interlocutor(@conversation)
    @messages = @conversation.messages
    @message = Message.new
  end



  private

    def conversation_params
      params.permit(:sender_id, :recipient_id)
    end

    def interlocutor(conversation)
      current_user == conversation.recipient ? conversation.sender : conversation.recipient
    end

end
