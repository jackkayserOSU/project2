require 'minitest/autorun'
require_relative '../models/user'

#Testing the user class and its methods
class UserTest < Minitest::Test

  # Create a fresh user before each test.
  def setup
    @user = User.new("jack", "jack@email.com", "123456")
  end

  # Tests that a user is created with the correct information.
  def test_user_creation
    assert_equal "jack", @user.username
    assert_equal "jack@email.com", @user.email
    assert_nil @user.address
    assert_empty @user.posts
    assert_instance_of Time, @user.created_at
  end

  # Tests that each user receives a unique ID.
  def test_unique_user_ids
    second_user = User.new("may", "may@email.com", "abcdef")

    refute_equal @user.user_id, second_user.user_id
    assert_equal @user.user_id + 1, second_user.user_id
  end

  # Tests that a valid username, email, and password allow user creation.
  def test_valid_user
    user = User.new("jeremy", "jeremy@email.com", "password")

    assert_equal "jeremy", user.username
    assert_equal "jeremy@email.com", user.email
  end

  # Tests that usernames shorter than three characters are rejected.
  def test_invalid_username
    assert_raises(ArgumentError) do
      User.new("ab", "test@email.com", "123456")
    end
  end

  # Tests that invalid email addresses are rejected.
  def test_invalid_email
    assert_raises(ArgumentError) do
      User.new("jack", "bademail", "123456")
    end
  end

  # Tests that passwords shorter than six characters are rejected.
  def test_invalid_password
    assert_raises(ArgumentError) do
      User.new("jack", "jack@email.com", "123")
    end
  end

  # Tests successful login with the correct credentials.
  def test_successful_login
    result = @user.login("jack@email.com", "123456")

    assert result
    assert @user.logged_in?
  end

  # Tests login failure when the password is incorrect.
  def test_login_with_wrong_password
    result = @user.login("jack@email.com", "wrongpassword")

    refute result
    refute @user.logged_in?
  end

  # Tests login failure when the email is incorrect.
  def test_login_with_wrong_email
    result = @user.login("wrong@email.com", "123456")

    refute result
    refute @user.logged_in?
  end

  # Tests that logout changes the user's login state.
  def test_logout
    @user.login("jack@email.com", "123456")
    assert @user.logged_in?

    @user.logout

    refute @user.logged_in?
  end

  # Tests that a new user begins with zero posts.
  def test_total_posts_starts_at_zero
    assert_equal 0, @user.total_posts
  end

  # Tests adding a post to the user's posts.
  def test_create_post
    post = Struct.new(:post_id).new(1)

    @user.create_post(post)

    assert_equal 1, @user.total_posts
    assert_includes @user.posts, post
  end

  # Tests replacing an existing post with an updated post.
  def test_update_post
    original_post = Struct.new(:post_id, :title).new(1, "Original")
    updated_post = Struct.new(:post_id, :title).new(1, "Updated")

    @user.create_post(original_post)
    @user.update_post(updated_post)

    assert_equal 1, @user.total_posts
    assert_equal "Updated", @user.posts.first.title
  end

  # Tests deleting a post by its ID.
  def test_delete_post
    post = Struct.new(:post_id).new(1)

    @user.create_post(post)
    assert_equal 1, @user.total_posts

    @user.delete_post(1)

    assert_equal 0, @user.total_posts
  end
end

#we are currently using structs on the posts because we have not yet implemented the post class. 
#Once the post class is implemented, we will replace the structs with actual Post objects.
