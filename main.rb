require 'tk'
require_relative 'managers/user_manager'
require_relative 'gui/login_view'

root = TkRoot.new

user_manager = UserManager.new

# Temporary user used to test the login screen.
user_manager.register_user(
    "jack",
    "jack@email.com",
    "123456"
)

LoginView.new(root, user_manager)

Tk.mainloop