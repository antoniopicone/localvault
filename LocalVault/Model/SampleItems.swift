//
//  SampleContacts.swift
//  SwiftDataContacts
//
//  Created by Stephan Dowless on 6/9/23.
//

import Foundation

struct SampleItems {
    static var items: [Item] = [
        .init(serviceUsername: "antonio", servicePassword: "secret", serviceUrl: "https://www.apple.com", lastUpdated: Date()),
        .init(serviceUsername: "antonio", servicePassword: "secret", serviceUrl: "https://www.icloud.com", lastUpdated: Date()),
        .init(serviceUsername: "antonio", servicePassword: "secret", serviceUrl: "https://www.microsoft.com", lastUpdated: Date()),
        .init(serviceUsername: "antonio", servicePassword: "secret", serviceUrl: "https://www.twitter.com", lastUpdated: Date())
        
    ]
}
