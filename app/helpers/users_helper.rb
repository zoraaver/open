module UsersHelper

    def display_friendship_status(user)

        @friendship = Friendship.new

        if user == current_user
            "You!"
        elsif current_user.friend_request_sent?(user) 
            "Friend request sent"
        elsif current_user.friend_request_received?(user)
            render(partial: "friendships/request", locals:{friendship: current_user.find_received_friend_request(user)})
        elsif current_user.friend?(user)
            @friendship = current_user.find_friendship(user)
            link_to("Unfriend", friendship_path(@friendship), method: :delete)
        else
            render({partial: "friendships/form", locals: {user: user, friendship: @friendship}})
        end

    end 

    def display_profile_header(user)
        if user == current_user
            "Hello #{user.name}!"
        else
            user.name
        end
    end

    def friend_display(user)
        if user == current_user
            "You have #{user.friends.count} friends:"
        else
            "#{user.name} has #{user.friends.count} friends:"
        end

    end

    def display_profile_pic(user)

        if user.profile_pic.attached?
            image_tag(url_for(user.profile_pic), class: 'card-img-top')
        else
            image_tag("http://linguaviva.com/wp-content/uploads/2017/03/facebook-avatar-300x189.jpg", class: "card-img-top")
        end

    end

    def display_thumbnail(user)

        if user.profile_pic.attached?
            image_tag(url_for(user.profile_pic), class: 'thumbnail')
        else
            image_tag("http://linguaviva.com/wp-content/uploads/2017/03/facebook-avatar-300x189.jpg", class: "thumbnail")
        end

    end

    def conversation_display(conversation)
        if conversation.user_count > 3
            result = conversation.users.where("users.id != ?", current_user.id).limit(2).pluck(:name).join(", ") + " and #{conversation.user_count - 3} more."
        else
            result = conversation.users.where("users.id != ?", current_user.id).limit(2).pluck(:name).join(", ")
        end

        if conversation.unread_messages(current_user) > 0 
            result = result + " (#{conversation.unread_messages(current_user)})"
        end

        result
    end


    def message_display(user)
        if current_user == user
            content_tag(:li, link_to("Messages (#{user.unread_messages})", conversations_path, class: "item"), class: "list-group-item")
        elsif current_user.friend?(user)
            content_tag(:li, link_to('Message', conversations_path(user_ids: [current_user.id, user.id]), method: 'post'), class: "list-group-item")
        end

    end
    
end
