require_relative 'databasequery'
require 'pg'
require_relative 'chirp'
require 'time'

class ChitterManager

    # FIND all the database bookmarks
    def self.all

        # Query
        result = DatabaseQuery.query("SELECT * FROM peeps;")

        # Return an array result[row] = Bookmark
        result.map do |chirp|
            Chirp.new(chirp['id'], chirp['message'], chirp['author'], chirp['date'])
        end
    end

    def self.add(content, author, yt)

        # Grab the time
        time = Time.new
        current_time = "#{time.hour} : #{time.min} , Day  #{time.day}  of  #{time.strftime('%B')}"
        
        # Content Error Fixing
        content = self.message_fixer(content)

        if yt # Attempt embed
            # If it's a video, the sub it out for a frame.
            if self.youtube?(content)

                selector = find_between("http", " ", content) #s://www.youtube.com/watch?v=JEGjlELJxC8&ab_channel=FarrahBeattie
    
                content = content.gsub("http"){""} #s://www.youtube.com/watch?v=JEGjlELJxC8&ab_channel=FarrahBeattie
                content = content.gsub(selector){self.embed_youtube(content)} 
            end
        end
  
        
        # Prepare and send the SQL
        prepared_string = "insert into peeps (message, author, date) VALUES ('#{content}', '#{author}', '#{current_time}') RETURNING id, message, author, date;"
        result = DatabaseQuery.query(prepared_string)
    end

    
    def self.youtube?(content)
        content.include? "youtube"
    end

    def self.message_fixer(content)
        # Double stuff the quotes so it don't break
        content = content.gsub("'"){"''"}

        # Fix Youtube Errors
        if self.youtube?(content) then content = content.insert(-1, ' ') end

        # Return
        return content
    end

    def self.embed_youtube(content)
        code = content[/\=(.*?)&/,1] # JEGjlELJxC8
        new_url = "https://www.youtube.com/embed/#{code}" # https://www.youtube.com/embed/JEGjlELJxC8
        new_message = '<iframe width="420" height="315" src="' + new_url + '"> </iframe>' # <iframe width="420" height="315" src="https://www.youtube.com/embed/JEGjlELJxC8"> </iframe>
    end

    def self.find_between(str1, str2, message)
        message[/#{str1}(.*?)#{str2}/m, 1]
    end
    
end