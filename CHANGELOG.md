# Changelog

https://keepachangelog.com/en/1.1.0/ 
- we will follow this as a guideline for keeping a changelog, do not worry about semver

## 2026-09-08 - (Auth)User and UserManager Backend

### Added
- Added username, email, and password validation to `User`
- Added user creation timestamps for recently registered user tracking
- Added login-state tracking with `logged_in?`
- Added `total_posts` helper for user post counts
- Added user registration workflow to `UserManager`
- Added duplicate username prevention
- Added duplicate email prevention
- Added user search by username
- Added user search by email
- Added user authentication through `UserManager`
- Added total user count support
- Added deleted account tracking
- Added recently registered user retrieval for dashboard statistics
- Added Minitest as a testing dependency
- Added automated tests for the `User` model
- Added tests for user creation and unique user IDs
- Added tests for username, email, and password validation
- Added tests for successful and unsuccessful login
- Added tests for logout behavior
- Added tests for user post create, update, delete, and count behavior

### Updated
- Expanded `UserManager` beyond the base UML CRUD operations to support project rubric requirements
- Updated user deletion to return the deleted user and track successful account deletions
- Updated `User` validation so invalid users are rejected before account creation
- Updated README with dependency installation instructions
- Updated README with Minitest testing instructions and examples
- Updated README with current authentication and user-management progress
- Improved method documentation and return descriptions

### Fixed
- Fixed deleted account tracking initialization
- Fixed user deletion logic so nonexistent users do not increase the deleted account count
- Fixed username validation messaging to match the three-character minimum
- Fixed minor documentation typos and formatting issues

### Testing
- Performed manual IRB testing of user creation
- Verified username validation rejects invalid usernames
- Verified successful and unsuccessful login behavior
- Verified logout and login-state behavior
- Added `User` automated test suite using Minitest

## 2026-09-07 - (Auth) - UML diagram outline

### Added
- Created `User` model based on the UML class diagram
- Added unique user ID generation
- Added bcrypt password hashing
- Added login and logout behavior
- Added user post create, update, and delete methods
- Created `UserManager` based on the UML class diagram
- Added Hash-based user storage
- Added create, retrieve, update, delete, and list user operations
- Added initial authentication feature branch setup

## 2026-09-07 - Main

### Added
- Created initial project folder structure
- Added GUI, model, manager, report, and test directories
- Added `Gemfile` with Tk and bcrypt
- Added README with Git workflow