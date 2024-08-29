# views/home_view.rb
class HomeView
    def guest_menu
      puts "\nWelcome to the Blog Platform!"
      puts "1. Sign Up"
      puts "2. Log In"
      puts "3. Exit"
      print "Choose an option: "
    end
  
    def logged_in_menu
      puts "\n1. Create a Post"
      puts "2. View All Posts"
      puts "3. Log Out"
      print "Choose an option: "
    end
  end
  