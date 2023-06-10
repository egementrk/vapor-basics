import Vapor

func routes(_ app: Application) throws {
    // http://127.0.0.1:8080
    app.get { req async in
        "It works!"
    }

    // http://127.0.0.1:8080/hello
    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    // MARK: - Dynamic Routes
    
    // /movies/dynamic
    app.get("movies", ":genre") { req async throws -> String in
        guard let genre = req.parameters.get("genre") else { throw Abort(.badRequest) }
        return "\(genre) Movies"
    }
    
    // movies/dynamic/dynamic
    app.get("movies", ":genre", ":year") { req async throws -> String in
        
        guard let genre = req.parameters.get("genre"),
        let year = req.parameters.get("year")
        else { throw Abort(.badRequest) }
        
        return "\(genre) Movies from \(year)"
    }
    
    app.get("customers", ":customerID") { req async throws -> String in
        
        guard let customerID = req.parameters.get("customerID", as: Int.self) else {
            throw Abort(.badRequest)
        }
        return "\(customerID)"
    }
    
    // MARK: - Working with Models
    
    // /movies
    app.get("movies") { req async in
        [Movie(title: "Batman Begins", year: 2005),
        Movie(title: "The Batman", year: 2022),
        Movie(title: "The Dark Knight Rises", year: 2012)]
    }
    
    // MARK: - Post Method
    app.post("movies") { req async throws in
        let movie = try req.content.decode(Movie.self)
        return movie
    }
    
    // MARK: - Query String
    
    // /hotels?sort=desc&search=houston
    app.get("hotels") { req async throws in
        let hotelQuery = try req.query.decode(HotelQuery.self)
        print(hotelQuery)
        return hotelQuery
    }
    
    // MARK: - Route Groups
    
    let users = app.grouped("users")
    
    // /users
    users.get { req async -> String in
        return "Users"
    }
    
    // /users/Int
    users.get(":userId") { req async throws -> String in
        guard let userId = req.parameters.get("userId") else { throw Abort(.badRequest) }
        return "UserId: \(userId)"
    }
    
    // /users/premium
    users.get("premium") { req async -> String in
        return "Premium"
    }
}
