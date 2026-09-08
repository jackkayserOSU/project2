# UserHub System

Ruby desktop GUI application for Web Development Project 2.

## Overview

UserHub is a Ruby/Tk desktop application that allows users to register, log in, manage profiles, create posts, and manage attachments.

Administrators can manage users, search system data, view dashboard statistics, and generate reports.

## Project Structure

- `models/` - User, Address, Post, and Attachment classes
- `managers/` - System-level management classes such as `UserManager`
- `gui/` - Tk GUI screens and application navigation
- `reports/` - Report generation and export functionality
- `test/` - Automated test files

## Dependencies

This project uses:

- Ruby
- Tk
- bcrypt
- Minitest

Install dependencies with:

```bash
bundle install
````

## Running the Application

The application will eventually be started with:

```bash
bundle exec ruby main.rb
```

> GUI integration is still in development.

While this is not needed  for the rubric, testing is very important for larger projects and will establish this.

## Testing

Automated tests are written using Minitest.

Test files are stored in the `test/` directory and should follow the naming format:

```text
<class_name>_test.rb
```

Examples:

```text
test/user_test.rb
test/user_manager_test.rb
test/post_test.rb
test/attachment_test.rb
```

### Creating a Test

Each test file should require Minitest and the class being tested.

Example:

```ruby
require 'minitest/autorun'
require_relative '../models/user'

class UserTest < Minitest::Test
  def test_example
    user = User.new("jack", "jack@email.com", "123456")

    assert_equal "jack", user.username
  end
end
```

Test methods should begin with `test_`.

Useful Minitest assertions include:

```ruby
assert condition
refute condition

assert_equal expected, actual
refute_equal unexpected, actual

assert_nil value
refute_nil value

assert_empty collection
assert_includes collection, value

assert_raises(ArgumentError) do
  # Code expected to raise an error
end
```

### Running a Test

Run tests from the root project directory.

To run the User tests:

```bash
bundle exec ruby test/user_test.rb
```

To run the UserManager tests:

```bash
bundle exec ruby test/user_manager_test.rb
```

A successful test run should finish with:

```text
0 failures, 0 errors
```

To run every test file:

```bash
for file in test/*_test.rb; do bundle exec ruby "$file"; done
```

## Current Progress

### Authentication / User Management

Implemented:

* User model based on UML
* Unique user IDs
* bcrypt password hashing
* User registration
* Login and logout
* Username, email, and password validation
* User search by ID, username, and email
* Duplicate username and email prevention
* User CRUD operations
* Total user tracking
* Deleted account tracking
* Recently registered user tracking
* Automated User model testing with Minitest

## Git Workflow

Keep `main` as the stable/integrated branch.

Create feature branches for development:

* `feat/auth`
* `feature/profiles`
* `feature/posts`
* `feature/reports`

Changes should be merged into `main` through pull requests once a feature is ready.

## Team

* Jack Kayser
* May Endo
* Jeremy Martin
* Ava Scheerer

```
