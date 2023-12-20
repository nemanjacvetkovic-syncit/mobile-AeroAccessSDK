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
    @objc dynamic var width: NSNumber?
    @objc dynamic var height: NSNumber?
    @objc dynamic var width_m: NSDecimalNumber?
    @objc dynamic var height_m: NSDecimalNumber?
    @objc dynamic var ppm: NSDecimalNumber?
    @objc dynamic var site_id: UUID?
    @objc dynamic var org_id: UUID?
    @objc dynamic var created_time: NSNumber?
    @objc dynamic var modified_time: NSNumber?
    
    convenience init(uuid_mobile: UUID? = nil, id: UUID? = nil, name: String? = nil, type: String? = nil, width: NSNumber? = nil, height: NSNumber? = nil, width_m: NSDecimalNumber? = nil, height_m: NSDecimalNumber? = nil, ppm: NSDecimalNumber? = nil, site_id: UUID? = nil, org_id: UUID? = nil, created_time: NSNumber? = nil, modified_time: NSNumber? = nil) {
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
    
    private enum CodingKeys: String, CodingKey {
        case uuid_mobile
        case id
        case name
        case type
        case width
        case height
        case width_m
        case height_m
        case ppm
        case site_id
        case org_id
        case created_time
        case modified_time
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(uuid_mobile, forKey: .uuid_mobile)
        try? container.encode(id, forKey: .id)
        try? container.encode(name, forKey: .name)
        try? container.encode(type, forKey: .type)
        if let value = width {
            let data = try? NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
            try? container.encode(data, forKey: .width)
        }
        if let value = height {
            let data = try? NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
            try? container.encode(data, forKey: .height)
        }
        if let value = width_m {
            let data = try? NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
            try? container.encode(data, forKey: .width_m)
        }
        if let value = height_m {
            let data = try? NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
            try? container.encode(data, forKey: .height_m)
        }
        if let value = ppm {
            let data = try? NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
            try? container.encode(data, forKey: .ppm)
        }
        try? container.encode(site_id, forKey: .site_id)
        try? container.encode(org_id, forKey: .org_id)
        if let value = created_time {
            let data = try? NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
            try? container.encode(data, forKey: .created_time)
        }
        if let value = modified_time {
            let data = try? NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
            try? container.encode(data, forKey: .modified_time)
        }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uuid_mobile = try? container.decode(UUID.self, forKey: .uuid_mobile)
        id = try? container.decode(UUID.self, forKey: .id)
        name = try? container.decode(String.self, forKey: .name)
        type = try? container.decode(String.self, forKey: .type)
        name = try? container.decode(String.self, forKey: .name)
        if let widthData = try? container.decode(Data.self, forKey: .width) {
            width = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSNumber.self, from: widthData)
        }
        if let heightData = try? container.decode(Data.self, forKey: .height) {
            height = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSNumber.self, from: heightData)
        }
        if let widthMData = try? container.decode(Data.self, forKey: .width_m) {
            width_m = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSDecimalNumber.self, from: widthMData)
        }
        if let heightMData = try? container.decode(Data.self, forKey: .height_m) {
            height_m = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSDecimalNumber.self, from: heightMData)
        }
        if let ppmData = try? container.decode(Data.self, forKey: .ppm) {
            ppm = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSDecimalNumber.self, from: ppmData)
        }
        site_id = try? container.decode(UUID.self, forKey: .site_id)
        org_id = try? container.decode(UUID.self, forKey: .org_id)
        if let createdTimeData = try? container.decode(Data.self, forKey: .created_time) {
            created_time = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSNumber.self, from: createdTimeData)
        }
        if let modifiedTimeData = try? container.decode(Data.self, forKey: .modified_time) {
            modified_time = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSNumber.self, from: modifiedTimeData)
        }
    }
}
