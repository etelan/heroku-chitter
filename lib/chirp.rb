class Chirp

    attr_reader :id, :content, :author, :date

    def initialize(id, content, author, date)
        @id = id
        @content = content 
        @author = author 
        @date = date
    end 

end