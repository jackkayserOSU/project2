require 'bcrypt'

# Represents a registered UserHub user.
# Stores account information, login state, address, and posts.
class User
    @@next_user_id = 1

    #creates a getter for the instance variables
    attr_reader :user_id, :username, :email, :address, :posts, :created_at

    # Creates a new user with a unique ID and hashed password.
    #
    # @param username [String] the user's username
    # @param email [String] the user's email address
    # @param password [String] the user's plaintext password
    def initialize(username, email, password)
        #Raise validation errors if the provided username, email, or password are invalid
        raise ArgumentError, "Invalid username, must be at least 3 characters" unless valid_username?(username)
        raise ArgumentError, "Invalid email, must match email format" unless valid_email?(email)
        raise ArgumentError, "Invalid password, must be at least 6 characters" unless valid_password?(password)


        #increment ID when initialize a new user
        @user_id = @@next_user_id
        @@next_user_id += 1

        @username = username
        @email = email 
        #handle using bcrypt
        @password = BCrypt::Password.create(password)

        #wait to see how it is implemented down the road
        @address = nil 
        @posts = []
        @logged_in = false
        @created_at = Time.now
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
    # @param post [Post] the post to add
    # @return [void] 
    def create_post(post)
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
    #Helpers 
    

    # Returns the user's login state. 
    # 
    # @return [Boolean] true if the user is logged in, otherwise false
    def logged_in?
        @logged_in
    end

    # Returns the total number of posts by a user 
    #
    # @return [Integer] the number of posts
    def total_posts
        @posts.length
    end


    # Validation form content
    private
    #Validate username
    # 
    # @param username [String] the username to validate
    # @return [Boolean] true if the username is valid, otherwise false
    def valid_username?(username)
        !username.nil? && username.length >= 3
    end

    # Validate password 
    # 
    # @param password [String] the password to validate
    # @return [Boolean] true if the password is valid, otherwise false
    def valid_password?(password)
        !password.nil? && password.length >= 6
    end

    # Validate email 
    # 
    # @param email [String] the email to validate
    # @return [Boolean] true if the email is valid, otherwise false
    def valid_email?(email)
        !email.nil? && email.match?(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
    end 
end