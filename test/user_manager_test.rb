require 'minitest/autorun'
require_relative '../managers/user_manager'

# Tests the UserManager class and its user-management functionality.
class UserManagerTest < Minitest::Test

  # Create a fresh UserManager before each test.
  def setup
    @manager = UserManager.new
  end

  # Tests that a new UserManager starts with no users.
  def test_manager_starts_empty
    assert_equal 0, @manager.total_users
    assert_empty @manager.get_all_users
  end

  # Tests registering and storing a new user.
  def test_register_user
    user = @manager.register_user(
      "jack",
      "jack@email.com",
      "123456"
    )

    assert_instance_of User, user
    assert_equal 1, @manager.total_users
    assert_equal user, @manager.get_user(user.user_id)
  end

  # Tests retrieving a user by their unique ID.
  def test_get_user_by_id
    user = @manager.register_user(
      "jack",
      "jack@email.com",
      "123456"
    )

    found_user = @manager.get_user(user.user_id)

    assert_equal user, found_user
  end

  # Tests that searching for a nonexistent ID returns nil.
  def test_get_nonexistent_user
    assert_nil @manager.get_user(9999)
  end

  # Tests finding a user by username.
  def test_find_user_by_username
    user = @manager.register_user(
      "jack",
      "jack@email.com",
      "123456"
    )

    found_user = @manager.find_user_by_username("jack")

    assert_equal user, found_user
  end

  # Tests that a nonexistent username returns nil.
  def test_find_nonexistent_username
    assert_nil @manager.find_user_by_username("nobody")
  end

  # Tests finding a user by email.
  def test_find_user_by_email
    user = @manager.register_user(
      "jack",
      "jack@email.com",
      "123456"
    )

    found_user = @manager.find_user_by_email("jack@email.com")

    assert_equal user, found_user
  end

  # Tests that a nonexistent email returns nil.
  def test_find_nonexistent_email
    assert_nil @manager.find_user_by_email("nobody@email.com")
  end

  # Tests that duplicate usernames are rejected.
  def test_duplicate_username
    @manager.register_user(
      "jack",
      "jack@email.com",
      "123456"
    )

    assert_raises(ArgumentError) do
      @manager.register_user(
        "jack",
        "different@email.com",
        "abcdef"
      )
    end
  end

  # Tests that duplicate emails are rejected.
  def test_duplicate_email
    @manager.register_user(
      "jack",
      "jack@email.com",
      "123456"
    )

    assert_raises(ArgumentError) do
      @manager.register_user(
        "different",
        "jack@email.com",
        "abcdef"
      )
    end
  end

  # Tests successful authentication.
  def test_successful_authentication
    user = @manager.register_user(
      "jack",
      "jack@email.com",
      "123456"
    )

    authenticated_user =
      @manager.authenticate_user("jack@email.com", "123456")

    assert_equal user, authenticated_user
    assert user.logged_in?
  end

  # Tests authentication with an incorrect password.
  def test_authentication_with_wrong_password
    @manager.register_user(
      "jack",
      "jack@email.com",
      "123456"
    )

    result =
      @manager.authenticate_user("jack@email.com", "wrongpassword")

    assert_nil result
  end

  # Tests authentication with an email that does not exist.
  def test_authentication_with_unknown_email
    result =
      @manager.authenticate_user("nobody@email.com", "123456")

    assert_nil result
  end

  # Tests total user counting.
  def test_total_users
    @manager.register_user(
      "jack",
      "jack@email.com",
      "123456"
    )

    @manager.register_user(
      "may",
      "may@email.com",
      "abcdef"
    )

    assert_equal 2, @manager.total_users
  end

  # Tests deleting an existing user.
  def test_delete_user
    user = @manager.register_user(
      "jack",
      "jack@email.com",
      "123456"
    )

    deleted_user = @manager.delete_user(user.user_id)

    assert_equal user, deleted_user
    assert_nil @manager.get_user(user.user_id)
    assert_equal 0, @manager.total_users
  end

  # Tests that successful deletions increase the deleted-user count.
  def test_deleted_user_count
    user = @manager.register_user(
      "jack",
      "jack@email.com",
      "123456"
    )

    @manager.delete_user(user.user_id)

    assert_equal 1, @manager.total_deleted_users
  end

  # Tests that deleting a nonexistent user does not increase the count.
  def test_nonexistent_delete_does_not_increase_count
    @manager.delete_user(9999)

    assert_equal 0, @manager.total_deleted_users
  end

  # Tests returning all registered users.
  def test_get_all_users
    jack = @manager.register_user(
      "jack",
      "jack@email.com",
      "123456"
    )

    may = @manager.register_user(
      "may",
      "may@email.com",
      "abcdef"
    )

    users = @manager.get_all_users

    assert_equal 2, users.length
    assert_includes users, jack
    assert_includes users, may
  end

  # Tests that recently registered users are returned newest first.
  def test_recently_registered_users
    jack = @manager.register_user(
      "jack",
      "jack@email.com",
      "123456"
    )

    # Ensure the users have slightly different creation times.
    sleep(0.001)

    may = @manager.register_user(
      "may",
      "may@email.com",
      "abcdef"
    )

    recent_users = @manager.recently_registered_users

    assert_equal may, recent_users.first
    assert_equal jack, recent_users.last
  end

  # Tests that the recent-user limit is respected.
  def test_recently_registered_user_limit
    6.times do |index|
      @manager.register_user(
        "user#{index}",
        "user#{index}@email.com",
        "123456"
      )

      sleep(0.001)
    end

    recent_users = @manager.recently_registered_users(5)

    assert_equal 5, recent_users.length
  end
end