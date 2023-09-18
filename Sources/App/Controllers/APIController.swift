//
//  APIController.swift
//  
//
//  Created by Egemen Türk on 18.09.2023.
//

import Vapor

struct APIController: RouteCollection {
    
    func boot(routes: Vapor.RoutesBuilder) throws {
        let api = routes.grouped("api")
        api.get("users", use: getUsers)
    }
    
    func getUsers(request: Request) throws -> Response {
        let users = [["name": "Egemen", "age": 22], ["name":"Alex", "age": 22]]
        let data = try JSONSerialization.data(withJSONObject: users, options: .prettyPrinted)
        return Response(status: .ok, body: Response.Body(data: data))
    }
}
