//
//  AeroAccessConstants.swift
//  Pods
//
//  Created by Nemanja Cvetkovic on 29.11.23..
//

import Foundation
import Alamofire

struct AeroAccessConstants {
    static let postBeaconPoints = "https://aeroaccess.syncitgroup.dev/api/import-beacon-points"
    static let postVirtualBeacons = "https://aeroaccess.syncitgroup.dev/api/import-virtual-beacons"
    static let postBeaconZones = "https://aeroaccess.syncitgroup.dev/api/import-beacon-zones"
    
    static let bearerToken = "1|0vbmqDzWmeZSOveUIzJcQYwRoLWPHd5OumsTanPK3f207959"
    
    static func getHeader() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(AeroAccessConstants.bearerToken)",
            "Accept": "application/json",
            "Content-Type" : "application/json"
        ]
        return headers
    }
    
    static let kLastApiCallDate = "LastApiCallDate"
}
