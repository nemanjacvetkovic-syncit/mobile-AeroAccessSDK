//
//  BeaconZonesData.swift
//  Alamofire
//
//  Created by Nemanja Cvetkovic on 29.11.23..
//

import Foundation

struct BeaconZonesData: Codable {
    var data: [BeaconZone]?
    
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
