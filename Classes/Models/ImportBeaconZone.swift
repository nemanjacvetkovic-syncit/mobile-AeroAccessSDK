//
//  ImportBeaconZone.swift
//  Alamofire
//
//  Created by Nemanja Cvetkovic on 29.11.23..
//

import Foundation

struct ImportBeaconZone: Codable {
    var importBeaconZones: BeaconZonesData?
    
    enum CodingKeys: String, CodingKey {
        case importBeaconZones = "import-beacon-zones"
    }
    
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
