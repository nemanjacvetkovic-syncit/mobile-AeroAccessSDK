//
//  MistMap.swift
//  Pods
//
//  Created by Nemanja Cvetkovic on 18.12.23..
//

import Foundation
import RealmSwift

class AAMistMap: Object, Codable {
    @objc dynamic var uuid_mobile: UUID?
    @objc dynamic var id: UUID?
    @objc dynamic var name: String?
    @objc dynamic var type: String?
    @objc dynamic var width: Int?
    @objc dynamic var height: Int?
    @objc dynamic var width_m: Double?
    @objc dynamic var height_m: Double?
    @objc dynamic var ppm: Double?
    @objc dynamic var site_id: UUID?
    @objc dynamic var org_id: UUID?
    @objc dynamic var created_time: Int?
    @objc dynamic var modified_time: Int?
    
    convenience init(uuid_mobile: UUID? = nil, id: UUID? = nil, name: String? = nil, type: String? = nil, width: Int? = nil, height: Int? = nil, width_m: Double? = nil, height_m: Double? = nil, ppm: Double? = nil, site_id: UUID? = nil, org_id: UUID? = nil, created_time: Int? = nil, modified_time: Int? = nil) {
        self.init()
        self.uuid_mobile = uuid_mobile
        self.id = id
        self.name = name
        self.type = type
        self.width = width
        self.height = height
        self.width_m = width_m
        self.height_m = height_m
        self.ppm = ppm
        self.site_id = site_id
        self.org_id = org_id
        self.created_time = created_time
        self.modified_time = modified_time
    }
}
