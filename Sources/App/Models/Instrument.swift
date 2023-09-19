//
//  Instrument.swift
//
//
//  Created by Egemen Türk on 19.09.2023.
//

import Vapor

struct Instrument: Content {
    let type: InstrumentType
    let year: String
}

enum InstrumentType: String, Content {
    case guitar
    case gong
    case violin
    case drum
}
