require 'sqlite3'

class User
    def makeHash(array)
        hash = Hash.new()
        hash['firstname'] = array[0]
        hash['lastname'] = array[1]
        hash['age'] = array[2]
        hash['password'] = array[3]
        hash['email'] = array[4]

        return hash
    end
    
    def create(user_info)
        begin
            db = SQlite3::Database.open "my_first_app.db"
            db.execute "INSERT INTO users VALUES ('#{user_info[0]}','#{user_info[1]}','#{user_info[2]}','#{user_info[3]}','#{user_info[4]}')"
        rescue SQlite3:: exception => e 
            puts "Execption occured"
            puts e            
        ensure
            id = db.last_insert_row_id
            db.close if db 
        end
    end

    def get(user_id)
        begin
            db = SQlite3::Database.open"my_first_app.db"
            db.execute "SELECT * FROM users WHERE rowid=#{user_id}"
        rescue SQlite3:: exception => e 
            puts "Execption occured"
            puts e            
        ensure
            db.close if db 
            return makeHash(user_id[0][0])
        end
    end

    def all
        begin
            db = SQlite3::Database.open"my_first_app.db"
            db.execute "SELECT * FROM users"
        rescue SQlite3:: exception => e 
            puts "Execption occured"
            puts e            
        ensure
            db.close if db 
            hashArray = []
            for user in users
                hash = makeHash(user)
                hashArray.push(hash)
            end
            return hashArray
        end
    end

    def update(user_id, attribute,value)
        begin
            db = SQlite3::Database.open"my_first_app.db"
            db.execute "UPDATE users SET #{attribute}=#{value} WHERE rowid=#{user_id}"
        rescue SQlite3:: exception => e 
            puts "Execption occured"
            puts e            
        ensure
            db.close if db 
        end
    end

    def destroy(user_id)
        begin
            db = SQlite3::Database.open"my_first_app.db"
            db.execute "DELETE FROM users WHERE rowid=#{user_id}"
        rescue SQlite3:: exception => e 
            puts "Execption occured"
            puts e            
        ensure
            db.close if db 
            p "User #{user_id} deleted."
        end
    end

    def match(email, password)
        begin
            db = SQlite3::Database.open"my_first_app.db"
            db.execute "SELECT rowid FROM users WHERE email='#{email}' AND password='#{password}'"
        rescue SQlite3:: exception => e 
            puts "Execption occured"
            puts e            
        ensure
            db.close if db 
            return id
        end
    end
end

user = User.new()
user.create(['Max','Potosky',33,'1234','mail@mail.com'])