//
//  MoviesController.swift
//
//
//  Created by Egemen Türk on 17.09.2023.
//

import Vapor

struct MoviesController: RouteCollection {
    
    func boot(routes: Vapor.RoutesBuilder) throws {
        let movies = routes.grouped("movie")
        movies.get(use: index)
        movies.post(use: create)
        
        movies.group(":year") { movie in
            movie.get(use: show)
        }
    }
    
    private func index(req: Request) async throws -> [Movie] {
        return [Movie(title: "Batman Begins", year: "2005"),
                Movie(title: "The Batman", year: "2022"),
                Movie(title: "The Dark Knight Rises", year: "2012")]
    }
    
    private func create(req: Request) async throws -> Movie {
        return Movie(title: "Joker", year: "2019")
    }
    
    private func show(req: Request) async throws -> [Movie] {
        guard let movieYear = req.parameters.get("year") as String? else {
            throw Abort(.badRequest)
        }
        let movies = [Movie(title: "Batman Begins", year: "2005"),
                      Movie(title: "The Batman", year: "2022"),
                      Movie(title: "The Dark Knight Rises", year: "2012")]
        
        let moviesByYear = movies.filter { $0.year == movieYear }
        return moviesByYear
    }
}
