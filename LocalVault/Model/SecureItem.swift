//
//  SecureItem.swift
//  LocalVault
//
//  Created by Antonio Picone on 29/10/23.
//
/*
import Foundation
import GRDB
import CryptoKit
// import SQLCipher

// Definizione del modello di dati `Item`
struct SecureItem: Codable, FetchableRecord, PersistableRecord {
    var id: UUID?
    var username: String
    var password: String
    var serviceUrl: URL
    var serviceName: String
}


// Classe per la gestione del database criptato
class ItemDatabase {
    private let dbQueue: DatabaseQueue

    init() throws {
        // Imposta la chiave di crittografia (assicurati di mantenere questa chiave in un posto sicuro)
        let encryptionKey: SymmetricKey = SymmetricKey(size: .bits256) // TODO: qui è una chiave causale

        // Configura il database criptato
        let dbPath = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("items.db")
        
        let config = Configuration()
        let passphrase = "LaTuaPassphraseSegreta"
       //  config.passphrase = passphrase
       //  config.fileProtection = .completeUnlessOpen
        dbQueue = try DatabaseQueue(path: dbPath.path, configuration: config)

        try dbQueue.write { db in
            // Crea la tabella per gli oggetti `Item`
            try db.create(table: "items", body: { table in
                table.autoIncrementedPrimaryKey("id")
                table.column("username", .text).notNull()
                table.column("password", .text).notNull()
                table.column("serviceUrl", .text).notNull()
                table.column("serviceName", .text).notNull()
            })
        }
    }

    // Funzione per inserire un nuovo oggetto `Item` nel database
    func insert(item: SecureItem) throws {
        try dbQueue.write { db in
            try item.insert(db)
        }
    }

    // Funzione per recuperare tutti gli oggetti `Item` dal database
    func getAllItems() throws -> [SecureItem] {
        return try dbQueue.read { db in
            return try SecureItem.fetchAll(db)
        }
    }
}
*/
