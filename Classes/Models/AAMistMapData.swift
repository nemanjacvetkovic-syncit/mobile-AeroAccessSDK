//
//  MistMapData.swift
//  Pods
//
//  Created by Nemanja Cvetkovic on 18.12.23..
//

import Foundation

struct AAMistMapData: Codable {
    var data: [AAMistMap]?
    
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
