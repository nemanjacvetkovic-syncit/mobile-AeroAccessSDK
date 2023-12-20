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
    @objc dynamic var width: Int = 0
    @objc dynamic var height: Int = 0
    @objc dynamic var widthM: Double = 0.0
    @objc dynamic var heightM: Double = 0.0
    @objc dynamic var ppm: Double = 0.0
    @objc dynamic var site_id: UUID?
    @objc dynamic var org_id: UUID?
    @objc dynamic var created_time: Int = 0
    @objc dynamic var modified_time: Int = 0
    
    convenience init(uuid_mobile: UUID? = nil, id: UUID? = nil, name: String? = nil, type: String? = nil, width: Int? = nil, height: Int? = nil, widthM: Double? = nil, heightM: Double? = nil, ppm: Double? = nil, site_id: UUID? = nil, org_id: UUID? = nil, created_time: Int? = nil, modified_time: Int? = nil) {
        self.init()
        self.uuid_mobile = uuid_mobile
        self.id = id
        self.name = name
        self.type = type
        self.width = width ?? 0
        self.height = height ?? 0
        self.widthM = widthM ?? 0
        self.heightM = heightM ?? 0
        self.ppm = ppm ?? 0
        self.site_id = site_id
        self.org_id = org_id
        self.created_time = created_time ?? 0
        self.modified_time = modified_time ?? 0
    }
}
