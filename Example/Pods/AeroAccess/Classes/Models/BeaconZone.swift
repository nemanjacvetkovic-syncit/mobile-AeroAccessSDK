//
//  BeaconZone.swift
//  Alamofire
//
//  Created by Nemanja Cvetkovic on 29.11.23..
//

import Foundation
import RealmSwift

class BeaconZone: Object, Codable {
    @objc dynamic var uuid_mobile: UUID?
    @objc dynamic var zone_name: String?
    @objc dynamic var zone_id: String?
    @objc dynamic var org_id: String?
    @objc dynamic var timestamp: String?
    @objc dynamic var id_area: UUID?
    
    convenience init(uuid_mobile: UUID? = nil, zone_name: String? = nil, zone_id: String? = nil, org_id: String? = nil, timestamp: String? = nil, id_area: UUID? = UUID(uuidString: "382d0aa9-4445-4288-b9cb-791d28067684")) {
        self.init()
        self.uuid_mobile = uuid_mobile
        self.zone_name = zone_name
        self.zone_id = zone_id
        self.org_id = org_id
        self.timestamp = timestamp
        self.id_area = id_area
    }
}
