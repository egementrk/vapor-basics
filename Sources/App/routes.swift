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
    
    // MARK: - Body Streaming
    
    // Increases the streaming body collection limit to 500kb
    app.routes.defaultMaxBodySize = "500kb"
    
    
    // MARK: - Working with Models
    
    // /movies
    app.get("movies") { req async in
        [Movie(title: "Batman Begins", year: "2005"),
         Movie(title: "The Batman", year: "2022"),
         Movie(title: "The Dark Knight Rises", year: "2012")]
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
        return hotelQuery
    }
    
    // MARK: - Route Groups
    
    let users = app.grouped("users")
    
    // GET /users
    users.get { req async -> String in
        return "Users"
    }
    
    // POST /users
    users.post { req async -> String in
        return "/users.post"
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
    
    // /films
    app.group("films") { films in
        films.on(.GET) { req async in
            "app.group /films"
        }
        
        // /films/:id
        films.group(":id") { film in
            
            // GET
            film.on(.GET) { req async in
                "app.group get /film/:id \n \(req.parameters.get("id") ?? "id?")"
            }
            // POST
            film.on(.POST) { req async in
                "app.group post /film/:id \n \(req.parameters.get("id") ?? "id?")"
            }
        }
    }
    
    // MARK: - Controllers
    
    try app.register(collection: MoviesController())
}
