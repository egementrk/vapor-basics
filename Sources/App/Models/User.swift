//
//  User.swift
//  
//
//  Created by Egemen Türk on 19.09.2023.
//

import Vapor

struct User: Content {
    let name: String
    let age: Int
    let instrument: Instrument?
}
