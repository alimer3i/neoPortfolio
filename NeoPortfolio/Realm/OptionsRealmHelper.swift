//
//  OptionsRealmHelper.swift
//  NeoPortfolio
//
//  Created by Ali Merhie on 2/6/22.
//

import Foundation
import RealmSwift

class OptionsRealmHelper: NSObject {
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
    
    static let shared: OptionsRealmHelper = OptionsRealmHelper()
    
    func save(data:[OptionsModel]) {
        let realm = try! Realm(configuration: config)
        let objectsDelete = realm.objects(OptionsModel.self)

        try! realm.write(){
            realm.delete(objectsDelete)
            realm.add(data)
        }
        NotificationCenter.default.post(name: .optionsUpdated, object: nil)
    }
    
    func load() -> Results<OptionsModel> {
        let realm = try! Realm(configuration: config)
        return realm.objects(OptionsModel.self)
    }
    
    func deleteAll() {
        let realm = try! Realm(configuration: config)
        try! realm.write({
            realm.deleteAll()
        })
    }
}
