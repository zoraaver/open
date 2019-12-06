module NotificationsHelper

    def display_notification(notification)
        post_blurb = notification.post_content
        comment_blurb = notification.comment_content

        post_blurb = post_blurb[0..40] + "..." if post_blurb.length > 40
        comment_blurb = comment_blurb[0..40] + "..." if comment_blurb.length > 40

        body = "#{link_to(notification.notifier_name, user_path(notification.notifier_name))} commented '#{comment_blurb}' on your post #{link_to(post_blurb, post_path(notification.post))}"
        body.html_safe
        
    end
end
