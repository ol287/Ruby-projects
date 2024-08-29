# views/post_view.rb
class PostView
  def create_post
    print "Enter the title of your post: "
    title = gets.chomp
    print "Enter the content of your post: "
    content = gets.chomp
    { title: title, content: content }
  end

  def view_posts(posts)
    if posts.empty?
      puts "No posts available."
    else
      posts.each_with_index do |post, index|
        puts "\nPost ##{index + 1}:"
        puts "Title: #{post.title}"
        puts "Content: #{post.content}"
        puts "Author: #{post.author}"
        puts "Comments: #{post.comments.size} comments"
        post.comments.each { |comment| puts "- #{comment.author}: #{comment.content}" }
      end
    end
  end
end
