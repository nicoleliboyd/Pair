//
//  Entity.swift
//  PairRandomizer
//
//  Created by David Boyd on 5/21/21.
//

import Foundation

class Entity: Codable {
    
    let fullName: String
    let uuid: String
    
    init(fullName: String, uuid: String = UUID().uuidString) {
        self.fullName = fullName
        self.uuid = uuid
    }
}//End of class

extension Entity: Equatable {
    
    static func == (lhs: Entity, rhs: Entity) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}//End of extension
