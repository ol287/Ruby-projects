class Comment
    attr_accessor :content, :author
  
    def initialize(content, author)
      @content = content
      @author = author
    end
  end