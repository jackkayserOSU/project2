require_relative '../models/user'

#Manages the collection of users in the UserHub System.
class UserManager
    # Initialize an empty collection of users.
    def initialize 
        @users = {} 
        @deleted_accounts_count = 0
    end

    # USER CRUD OPERATIONS

    # Adds a new user to the System.
    #
    # @param uuser [User] the user to add
    # @return [void]
    def create_user(user)
        @users[user.user_id] = user
    end

    # Retrieves a user by their unique ID.
    #
    # @param user_id [Integer] the unique ID of the user
    # @return [User, nil] the user if found, otherwise nil
    def get_user(user_id)
        @users[user_id]
    end

    # Deletes a user from the System.
    #
    # @param user_id [Integer] the unique ID of the user to delete
    # @return [User, nil] the deleted user if found and deleted, otherwise nil
    def delete_user(user_id)
        deleted_user =@users.delete(user_id)

        #to keep track of deleted users 
        @deleted_accounts_count += 1 unless deleted_user.nil?

        deleted_user
    end

    # Updates an existing user's information.
    #
    # @param user [User] the updated user object
    # @return [void]
    def update_user(user)
        @users[user.user_id] = user if @users.key?(user.user_id)
    end

    # return all users in the system
    #
    # @return [Array<User>] an array of all users
    def get_all_users
        @users.values
    end

    # Rubric features 

    # Registers a new user and adds them to the System.
    #
    # @param username [String] the user's username
    # @param email [String] the user's email address
    # @param password [String] the user's plaintext password
    # @return [User] the newly created user
    def register_user(username, email, password)
        raise ArgumentError, "Username already taken" if username_taken?(username)
        raise ArgumentError, "Email already registered" if email_registered?(email)
        user = User.new(username, email, password)  
        create_user(user)
        user
    end 

    # Finds a user by their username.
    #
    # @param username [String] the username to search for
    # @return [User, nil] the user if found, otherwise nil
    def find_user_by_username(username)
        @users.values.find { |user| user.username == username }
    end

    # Finds a user by their email address
    #
    # @param email [String] the email to search for
    # @return [User, nil] the user if found, otherwise nil
    def find_user_by_email(email)
        @users.values.find { |user| user.email == email }
    end


    # Authenticates a user with the provided credentials. 
    #
    # @param email [String] the email entered by the user
    # @param password [String] the plaintext password entered by the user
    # @return [User, nil] the user if authentication is successful, otherwise nil
    def authenticate_user(email, password)
        user = find_user_by_email(email)
        return nil unless user
        user.login(email, password) ? user : nil
    end
    
    # Returns the total number of users in the System.
    #
    # @return [Integer] the total number of users
    def total_users
        @users.size
    end

    # Returns the total number of users deleted from the System.
    #
    # @return [Integer] the total number of users deleted
    def total_deleted_users
        @deleted_accounts_count
    end

   
    # Returns the most recently registered users.
    #
    # @param limit [Integer] maximum number of users to return
    # @return [Array<User>] recently registered users
    def recently_registered_users(limit = 5)
        @users.values
              .sort_by(&:created_at)
              .reverse
              .first(limit)
    end

    #Helpers 
    private
    # Checks if a username is already taken.
    #
    # @param username [String] the username to check
    # @return [Boolean] true if the username is taken, otherwise false
    def username_taken?(username)
        !find_user_by_username(username).nil?
    end

    # Checks if an email is already registered.
    #
    # @param email [String] the email to check
    # @return [Boolean] true if the email is registered, otherwise false
    def email_registered?(email)
        !find_user_by_email(email).nil?
    end

end

