# models/post.rb
class Post
    attr_accessor :title, :content, :author, :comments
  
    def initialize(title, content, author)
      @title = title
      @content = content
      @author = author
      @comments = []
    end
  
    def add_comment(comment)
      @comments << comment
    end
  end
  