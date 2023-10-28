//
//  Item.swift
//  LocalVault
//
//  Created by Antonio Picone on 28/10/23.
//

import Foundation
import SwiftData

@Model
class Item: ObservableObject {
    var lastUpdated: Date
    var serviceUsername: String
    var servicePassword: String
    var serviceUrl: String
    
    

    
    init(serviceUsername: String, servicePassword: String, serviceUrl: String, lastUpdated: Date) {
        self.lastUpdated = lastUpdated
        self.serviceUsername = serviceUsername
        self.servicePassword = servicePassword
        self.serviceUrl = serviceUrl
    }
}

extension Item: Identifiable { }


extension Item: Hashable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.serviceUrl == rhs.serviceUsername
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(serviceUsername)
    }
}
