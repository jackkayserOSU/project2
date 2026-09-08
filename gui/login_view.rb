require 'tk'
require_relative 'theme'

#Display the login view for the system 
class LoginView
    #Creates the login view 
    #
    #@param root [TkRoot] the root window for the GUI
    #@param user_manager [UserManager] the user manager to handle user operations
    def initialize(root, user_manager)
        @root = root 
        @user_manager = user_manager

        build_view
    end

    # Builds the login view components.
    # private so that it is not accessible outside of the class
    private 

    def build_view
        @root.title = "UserHub - Login"
        @root.background = Theme::LIGHT_GRAY
        @root.minsize(500, 400)

        # Top scarlet header.
        header = TkFrame.new(@root) do
        background Theme::SCARLET
        end

        header.pack(
        fill: "x"
        )

        TkLabel.new(header) do
        text "USERHUB"
        background Theme::SCARLET
        foreground Theme::WHITE
        font "Arial 20 bold"

        pack(
            pady: 15
        )
        end

        # Main login container.
        container = TkFrame.new(@root) do
        background Theme::WHITE
        end

        container.pack(
        padx: 50,
        pady: 35,
        ipadx: 30,
        ipady: 20
        )

        TkLabel.new(container) do
        text "Login"
        background Theme::WHITE
        foreground Theme::CHARCOAL
        font "Arial 18 bold"

        pack(
            pady: 10
        )
        end

        TkLabel.new(container) do
        text "Email"
        background Theme::WHITE
        foreground Theme::CHARCOAL

        pack(
            anchor: "w"
        )
        end

        @email_entry = TkEntry.new(container)

        @email_entry.pack(
        fill: "x",
        pady: 5
        )

        TkLabel.new(container) do
        text "Password"
        background Theme::WHITE
        foreground Theme::CHARCOAL

        pack(
            anchor: "w",
            pady: [10, 0]
        )
        end

        @password_entry = TkEntry.new(container)
        @password_entry.show = "*"

        @password_entry.pack(
        fill: "x",
        pady: 5
        )

        login_button = TkButton.new(container)

        login_button.text = "LOGIN"
        login_button.background = Theme::SCARLET
        login_button.foreground = Theme::WHITE
        login_button.activebackground = Theme::CHARCOAL
        login_button.activeforeground = Theme::WHITE

        login_button.command(
            proc { attempt_login }
        )

        login_button.pack(
            fill: "x",
            pady: 15
        )

        @message_label = TkLabel.new(container) do
        text ""
        background Theme::WHITE
        foreground Theme::SCARLET
        end

        @message_label.pack(
        pady: 5
        )
    end

    # Attempts to authenticate the entered credentials.
    def attempt_login
        email = @email_entry.get.strip
        password = @password_entry.get

        if email.empty? || password.empty?
        @message_label.configure(
            "text" => "Please enter an email and password."
        )

        return
        end

        user = @user_manager.authenticate_user(email, password)

        if user
        @message_label.configure(
            "text" => "Login successful!"
        )

        # Dashboard navigation will be added later.
        else
        @message_label.configure(
            "text" => "Invalid email or password."
        )
        end
    end
end