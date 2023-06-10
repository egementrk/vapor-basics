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
}
