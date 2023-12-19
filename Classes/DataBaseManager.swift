//
//  DataBaseManager.swift
//  Pods
//
//  Created by Nemanja Cvetkovic on 29.11.23..
//

import Foundation
import RealmSwift

class DataBaseManager {
    private var database: Realm
    static let shared = DataBaseManager()
    
    private init() {
        database = try! Realm()
    }
    
    //MARK: BeaconPoint
    func addData(beaconPoint: BeaconPoint) {
        try! database.write {
            database.add(beaconPoint)
        }
    }
    
    func getBeaconPoints() -> [BeaconPoint]? {
        let results: [BeaconPoint] = database.objects(BeaconPoint.self).toArray(ofType: BeaconPoint.self)
        return results.count > 0 ? results : nil
    }
    
    func deleteAllBeaconPoints() {
        try! database.write({
            let allBeaconPoints = database.objects(BeaconPoint.self)
            database.delete(allBeaconPoints)
        })
    }
    
    //MARK: VirtualBeacon
    func addData(virtualBeacon: VirtualBeacon) {
        try! database.write {
            database.add(virtualBeacon)
        }
    }
    
    func getVirtualBeacon() -> [VirtualBeacon]? {
        let results: [VirtualBeacon] = database.objects(VirtualBeacon.self).toArray(ofType: VirtualBeacon.self)
        return results.count > 0 ? results : nil
    }
    
    func deleteAllVirtualBeacons() {
        try! database.write({
            let allVirtualBeacons = database.objects(VirtualBeacon.self)
            database.delete(allVirtualBeacons)
        })
    }
    
    //MARK: BeaconZone
    
    func addData(beaconZone: BeaconZone) {
        try! database.write {
            database.add(beaconZone)
        }
    }
    
    func getBeaconZone() -> [BeaconZone]? {
        let results: [BeaconZone] = database.objects(BeaconZone.self).toArray(ofType: BeaconZone.self)
        return results.count > 0 ? results : nil
    }
    
    func deleteAllBeaconZones() {
        try! database.write({
            let allBeaconZones = database.objects(BeaconZone.self)
            database.delete(allBeaconZones)
        })
    }
    
    //MARK: MistMaps
    
    func addData(aaMistMaps: [AAMistMap]) {
        try! database.write {
            database.add(aaMistMap)
        }
    }
    
    func getAAMistMap() -> [AAMistMap]? {
        let results: [AAMistMap] = database.objects(AAMistMap.self).toArray(ofType: AAMistMap.self)
        return results.count > 0 ? results : nil
    }
    
    func deleteAllAAMistMaps() {
        try! database.write({
            let allAAMistMaps = database.objects(AAMistMap.self)
            database.delete(allAAMistMaps)
        })
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }

        return array
    }
}
