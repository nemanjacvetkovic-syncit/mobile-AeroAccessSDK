//
//  ImportBeaconPoint.swift
//  Alamofire
//
//  Created by Nemanja Cvetkovic on 29.11.23..
//

import Foundation

struct ImportBeaconPoint: Codable {
    var importBeaconPoints: BeaconPointsData?
    
    enum CodingKeys: String, CodingKey {
        case importBeaconPoints = "import-beacon-points"
    }
    
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
