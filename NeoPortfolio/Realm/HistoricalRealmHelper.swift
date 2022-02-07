//
//  HistoricalRealmHelper.swift
//  NeoPortfolio
//
//  Created by Ali Merhie on 2/6/22.
//

import Foundation
import RealmSwift

class HistoricalRealmHelper: NSObject {
    /// path for realm file
    lazy private var realmURL: URL = {
        return Realm.Configuration.defaultConfiguration.fileURL!
    }()
    lazy private var config:Realm.Configuration = {
        return Realm.Configuration(
            fileURL: self.realmURL,
            inMemoryIdentifier: nil,
            readOnly: false,
            schemaVersion: 1,
            migrationBlock: nil,
            deleteRealmIfMigrationNeeded: false,
            objectTypes: nil)
    }()
    
    static let shared: HistoricalRealmHelper = HistoricalRealmHelper()
    
    func save(data:[HistoricalModel]) {
        let realm = try! Realm(configuration: config)
        let objectsDelete = realm.objects(HistoricalModel.self)

        try! realm.write(){
            realm.delete(objectsDelete)
            realm.add(data)
        }
        NotificationCenter.default.post(name: .historicalUpdated, object: nil)
    }
    
    func load() -> Results<HistoricalModel> {
        let realm = try! Realm(configuration: config)
        return realm.objects(HistoricalModel.self)
    }
    
    func deleteAll() {
        let realm = try! Realm(configuration: config)
        try! realm.write({
            realm.deleteAll()
        })
    }
}
