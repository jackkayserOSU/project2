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
- `test/` - Test files

## Dependencies

This project uses:

- Ruby
- Tk
- bcrypt

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
