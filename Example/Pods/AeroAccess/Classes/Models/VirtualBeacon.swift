//
//  VirtualBeacon.swift
//  Alamofire
//
//  Created by Nemanja Cvetkovic on 29.11.23..
//

import Foundation
import RealmSwift

class VirtualBeacon: Object, Codable {
    @objc dynamic var uuid_mobile: UUID?
    @objc dynamic var uuid_mist_analytics: UUID?
    @objc dynamic var zone_name: String?
    @objc dynamic var zone_id: String?
    @objc dynamic var org_id: String?
    @objc dynamic var timestamp: String?
    
    convenience init(uuid_mobile: UUID? = nil, uuid_mist_analytics: UUID? = nil, zone_name: String? = nil, zone_id: String? = nil, org_id: String? = nil, timestamp: String? = nil) {
        self.init()
        self.uuid_mobile = uuid_mobile
        self.uuid_mist_analytics = uuid_mist_analytics
        self.zone_name = zone_name
        self.zone_id = zone_id
        self.org_id = org_id
        self.timestamp = timestamp
    }
}
