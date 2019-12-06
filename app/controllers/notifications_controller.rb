class NotificationsController < ApplicationController

    def index
        if params[:m]
            @notifications = current_user.notifications.order(created_at: :desc)
        else
            @notifications = current_user.unread_notifications.order(created_at: :desc)
        end
    end
end
