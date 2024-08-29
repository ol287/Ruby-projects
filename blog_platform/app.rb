# app.rb

# Require necessary files for the application, including models and views.
require_relative 'models/user'
require_relative 'models/post'
require_relative 'models/comment'
require_relative 'models/database'
require_relative 'views/home_view'
require_relative 'views/post_view'
require_relative 'views/user_view'

# Define the main BlogApp class that manages the entire blog application.
class BlogApp
  # Initialize the application, setting up the database, views, and current user state.
  def initialize
    @db = Database.new             # Initialize the database connection or instance.
    @home_view = HomeView.new      # Initialize the home view.
    @post_view = PostView.new      # Initialize the post view.
    @user_view = UserView.new      # Initialize the user view.
    @current_user = nil            # Start with no user logged in.
  end

  # The main method to run the application, handling user interaction in a loop.
  def run
    loop do
      if @current_user
        # Show logged-in user menu if a user is logged in.
        @home_view.logged_in_menu
        choice = gets.chomp.to_i   # Get the user's choice from the menu.
        case choice
        when 1 then create_post    # Option to create a post.
        when 2 then view_posts     # Option to view all posts.
        when 3 then log_out        # Option to log out.
        else
          puts "Invalid choice."  # Handle invalid menu options.
        end
      else
        # Show guest menu if no user is logged in.
        @home_view.guest_menu
        choice = gets.chomp.to_i   # Get the user's choice from the menu.
        case choice
        when 1 then sign_up        # Option to sign up.
        when 2 then log_in         # Option to log in.
        when 3 then exit           # Option to exit the application.
        else
          puts "Invalid choice."  # Handle invalid menu options.
        end
      end
    end
  end

  # Handle user sign-up process.
  def sign_up
    user_info = @user_view.sign_up              # Get sign-up information from the user.
    user = User.new(user_info[:username], user_info[:password]) # Create a new user object.
    @db.add_user(user)                          # Add the user to the database.
    puts "User created successfully."           # Confirm successful user creation.
  end

  # Handle user log-in process.
  def log_in
    credentials = @user_view.log_in             # Get log-in credentials from the user.
    user = @db.find_user(credentials[:username])# Find the user in the database.
    if user && user.password == credentials[:password] # Check if the password is correct.
      @current_user = user                      # Set the current user if login is successful.
      puts "Welcome, #{@current_user.username}!"# Welcome the user.
    else
      puts "Invalid username or password."      # Handle failed login attempt.
    end
  end

  # Handle user log-out process.
  def log_out
    @current_user = nil                         # Clear the current user.
    puts "You have logged out."                 # Confirm the user has logged out.
  end

  # Handle post creation process.
  def create_post
    post_info = @post_view.create_post          # Get post information from the user.
    post = Post.new(post_info[:title], post_info[:content], @current_user.username) # Create a new post object.
    @db.add_post(post)                          # Add the post to the database.
    puts "Post created successfully."           # Confirm successful post creation.
  end

  # Handle viewing of all posts.
  def view_posts
    posts = @db.all_posts                       # Retrieve all posts from the database.
    @post_view.view_posts(posts)                # Display the posts using the post view.
  end
end

# Create a new instance of the BlogApp and start the application.
app = BlogApp.new
app.run
