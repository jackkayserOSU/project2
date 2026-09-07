require_relative '../models/user'

#Manages the collection of users in the UserHub System.
class UserManager
    # Initialize an empty collection of users.
    def initialize 
        @users = {} 
    end

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
    # @return [void]
    def delete_user(user_id)
        @users.delete(user_id)
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
end

