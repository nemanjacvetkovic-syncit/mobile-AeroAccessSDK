//
//  ApiService.swift
//  Pods
//
//  Created by Nemanja Cvetkovic on 29.11.23..
//

import Foundation
import Alamofire

class ApiService {
    static func postBeaconPoints(beaconPoints: [BeaconPoint], completion: @escaping (_ success: Bool) -> Void) {
        do {
            let params = try BeaconPointsData(data: beaconPoints).asDictionary()
            AF.request(AeroAccessConstants.postBeaconPoints, method: .post, parameters: params, encoding: JSONEncoding.default, headers: AeroAccessConstants.getHeader()).response { response in
                if response.hasSuccessStatusCode {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        } catch {
            print("json error when creating body")
            completion(false)
        }
    }
    
    static func postVirtualBeacons(virtualBeacons: [VirtualBeacon], completion: @escaping (_ success: Bool) -> Void) {
        do {
            let params = try VirtualBeaconsData(data: virtualBeacons).asDictionary()
            AF.request(AeroAccessConstants.postVirtualBeacons, method: .post, parameters: params, encoding: JSONEncoding.default, headers: AeroAccessConstants.getHeader()).response { response in
                if response.hasSuccessStatusCode {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        } catch {
            print("json error when creating body")
            completion(false)
        }
    }
    
    static func postBeaconZones(beaconZones: [BeaconZone], completion: @escaping (_ success: Bool) -> Void) {
        do {
            let params = try BeaconZonesData(data: beaconZones).asDictionary()
            AF.request(AeroAccessConstants.postBeaconZones, method: .post, parameters: params, encoding: JSONEncoding.default, headers: AeroAccessConstants.getHeader()).response { response in
                if response.hasSuccessStatusCode {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        } catch {
            print("json error when creating body")
            completion(false)
        }
    }
    
    static func postMistMaps(aaMistMaps: [AAMistMap], completion: @escaping (_ success: Bool) -> Void) {
        do {
            let params = try AAMistMapData(data: aaMistMaps).asDictionary()
            AF.request(AeroAccessConstants.postMistMaps, method: .post, parameters: params, encoding: JSONEncoding.default, headers: AeroAccessConstants.getHeader()).response { response in
                if response.hasSuccessStatusCode {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        } catch {
            print("json error when creating body")
            completion(false)
        }
    }
}

extension AFDataResponse {
    
    var hasSuccessStatusCode: Bool {
        if let response = response {
            return 200...299 ~= response.statusCode
        }
        return false
    }
    
    var hasUnauthorizedStatusCode: Bool {
        if let response = response {
            return response.statusCode == 401
        }
        return false
    }
}
