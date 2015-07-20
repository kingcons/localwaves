json.message "Soundcloud account access granted for '#{@user.username}'!"
json.user @user, :username, :email, :access_token, :city, :state, :artist_name
