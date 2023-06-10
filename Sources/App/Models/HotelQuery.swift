//
//  HotelQuery.swift
//  
//
//  Created by Egemen TÜRK on 10.06.2023.
//

import Vapor

struct HotelQuery: Content {
    let sort: String?
    let search: String?
}
