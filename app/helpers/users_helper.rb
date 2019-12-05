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

    def other_users(conversation)
        conversation.users.where("users.id != ?", current_user.id).pluck(:name).join(" ")
    end
    
end
