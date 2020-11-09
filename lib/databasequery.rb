require 'pg'
require 'uri'

class DatabaseQuery
  def self.setup()
    uri = URI.parse(ENV["DATABASE_URL"])
    p "Connecting"
    @@connection = PG.connect({
      host: uri.host,
      dbname: uri.path[1..-1],
      user: uri.user,
      password: uri.password
    })

    # @@connection = PG.connect(dbname: 'chitter_test')
  end

  def self.query(sql)
    puts sql
    @@connection.exec(sql)
  end
end
