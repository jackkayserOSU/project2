require 'bcrypt'

# Represents a registered UserHub user.
# Stores account information, login state, address, and posts.
class User
    @@next_user_id = 1

    #creates a getter for the instance variables
    attr_reader :user_id, :username, :email, :address, :posts

    # Creates a new user with a unique ID and hashed password.
    #
    # @param username [String] the user's username
    # @param email [String] the user's email address
    # @param password [String] the user's plaintext password
    def initialize(username, email, password)
        
        #increment ID when initialize a new user
        @user_id = @@next_user_id
        @@next_user_id += 1

        @username = username
        @email = email 
        #handle using bcrypt
        @password = BCrypt::Password.create(password)

        @address = nil 
        @posts = []
        @logged_in = false
    end 

    # Attempts to log the user in with the provided credentials.
    #
    # @param email [String] the email entered by the user
    # @param password [String] the plaintext password entered by the user
    # @return [Boolean] true if the credentials are valid, otherwise false
    def login(email, password)
        if @email == email && BCrypt::Password.new(@password) == password
            @logged_in = true
            true 
        else 
            false
        end
    end

    # Logs the user out of the system.
    #
    # @return [void]
    def logout
        @logged_in = false
    end


    # Adds a post to the users collection of posts
    #
    # @param pos [Post] the post to add
    # @return [void] 
    def create_posts(post)
        @posts << post
    end

    # Updates an existing post owned by the user.
    #
    # @param post [Post] the updated post
    # @return [void]
    def update_post(post)
        index = @posts.index do |existing_post|
        existing_post.post_id == post.post_id
        end
        
         @posts[index] = post unless index.nil?
    end

    # Deletes a post owned by the user.
    #
    # @param post_id [Integer] ID of the post to delete
    # @return [void]
    def delete_post(post_id)
        @posts.delete_if { |post| post.post_id == post_id }
    end

end


