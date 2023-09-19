//
//  APIController.swift
//  
//
//  Created by Egemen Türk on 18.09.2023.
//

import Vapor

struct APIController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let api = routes.grouped("api")
        api.get("users", use: getUsers)
        api.post("users", use: postUser)
    }
    
    func getUsers(request: Request) throws -> [User] {
        let users = [User(name: "James", age: 22, instrument: Instrument(type: .guitar, year: "1990")),
                     User(name: "Dave", age: 22, instrument: nil)]
        return users
    }
    
    func postUser(request: Request) throws -> Response {
        let user = try request.content.decode(User.self)
        print(user)
        return Response(status: .ok)
    }
}
