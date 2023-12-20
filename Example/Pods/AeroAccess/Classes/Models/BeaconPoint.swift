//
//  BeaconPoint.swift
//  Alamofire
//
//  Created by Nemanja Cvetkovic on 29.11.23..
//

import Foundation
import RealmSwift

class BeaconPoint: Object, Codable {
    @objc dynamic var uuid_mobile: UUID?
    @objc dynamic var language: String?
    @objc dynamic var host: String?
    @objc dynamic var platform: String?
    @objc dynamic var manufactur: String?
    @objc dynamic var model: String?
    @objc dynamic var os: String?
    @objc dynamic var latitude_x: String?
    @objc dynamic var longitude_y: String?
    @objc dynamic var timestamp: String?
    
    convenience init(uuid_mobile: UUID? = nil, language: String? = nil, host: String? = nil, platform: String? = nil, manufactur: String? = nil, model: String? = nil, os: String? = nil, latitude_x: String? = nil, longitude_y: String? = nil, timestamp: String? = nil) {
        self.init()
        self.uuid_mobile = uuid_mobile
        self.language = language
        self.host = host
        self.platform = platform
        self.manufactur = manufactur
        self.model = model
        self.os = os
        self.latitude_x = latitude_x
        self.longitude_y = longitude_y
        self.timestamp = timestamp
    }
}
