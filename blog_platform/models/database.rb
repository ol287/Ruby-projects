# models/database.rb
class Database
    def initialize
      @users = []
      @posts = []
    end
  
    def add_user(user)
      @users << user
    end
  
    def find_user(username)
      @users.find { |user| user.username == username }
    end
  
    def add_post(post)
      @posts << post
    end
  
    def all_posts
      @posts
    end
  end
  