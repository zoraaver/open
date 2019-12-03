module UsersHelper

    def display_friendship_status(user)

        @friendship = Friendship.new

        if current_user.friend_request_sent?(user) 
            "Friend request sent"
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
    
end
