//
//  AeroAccess.swift
//  AeroAccess
//
//  Created by Nemanja Cvetkovic on 29.11.23..
//

import Foundation

public protocol AeroAccessService {
    var isStarted: Bool { get }
    func start()
    func stop()
}

#if !targetEnvironment(simulator)

import MistSDK

public class AeroAccess: NSObject, AeroAccessService {
    let mistManager: IndoorLocationManager
    var isStarted: Bool = false
    
    init(accessToken: String) {
        self.mistManager = IndoorLocationManager.sharedInstance(accessToken)
    }
    
    public func start() {
        mistManager.virtualBeaconsDelegate = self
        mistManager.zonesDelegate = self
        mistManager.mapsListDelegate = self
        mistManager.start(with: self)
        isStarted = true
    }
    
    public func stop() {
        mistManager.stop()
        isStarted = false
    }
    
    private func shouldApiCall() {
        guard let lastDate = UserDefaults.standard.value(forKey: AeroAccessConstants.kLastApiCallDate) as? Date else {
            UserDefaults.standard.setValue(Date(), forKey: AeroAccessConstants.kLastApiCallDate)
            return
        }
        let timeElapsed: Int = Int(Date().timeIntervalSince(lastDate))
        if timeElapsed > 5 * 60 {
            sendBeaconPoints()
            sendVirtualBeacons()
            sendBeaconZones()
            UserDefaults.standard.setValue(Date(), forKey: AeroAccessConstants.kLastApiCallDate)
            UserDefaults.standard.synchronize()
        }
    }
    
    private func sendBeaconPoints() {
        if let beaconPoints = DataBaseManager.shared.getBeaconPoints() {
            ApiService.postBeaconPoints(beaconPoints: beaconPoints) { [weak self] success in
                if success {
                    DataBaseManager.shared.deleteAllBeaconPoints()
                    debugPrint(">>> BeaconPoints sent and deleted <<<")
                } else {
//                    self?.sendBeaconPoints()
                }
            }
        }
    }
    
    private func sendVirtualBeacons() {
        if let virtualBeacons = DataBaseManager.shared.getVirtualBeacon() {
            ApiService.postVirtualBeacons(virtualBeacons: virtualBeacons) { [weak self] success in
                if success {
                    DataBaseManager.shared.deleteAllVirtualBeacons()
                    debugPrint(">>> VirtualBeacons sent and deleted <<<")
                } else {
//                    self?.sendVirtualBeacons()
                }
            }
        }
    }
    
    private func sendBeaconZones() {
        if let beaconZones = DataBaseManager.shared.getBeaconZone() {
            ApiService.postBeaconZones(beaconZones: beaconZones) { [weak self] success in
                if success {
                    DataBaseManager.shared.deleteAllBeaconZones()
                    debugPrint(">>> BeaconZones sent and deleted <<<")
                } else {
//                    self?.sendBeaconZones()
                }
            }
        }
    }
}

extension AeroAccess: IndoorLocationDelegate {
    func didUpdate(_ map: MistMap!) {
        debugPrint(">>> didUpdate MistMap.name = \(map.name.description)")
    }

    func didUpdateRelativeLocation(_ relativeLocation: MistPoint!) {
        let language = Locale.current.language.languageCode?.identifier
        let platform = "iOS"
        let manufactur = "Apple"
        let model = UIDevice.modelName
        let osVersion = UIDevice.current.systemVersion
        let mobileUUID = UIDevice.current.identifierForVendor
        let timestamp = NSDate().timeIntervalSince1970
        let timestampInt = Int(timestamp)
        let timestampString = String(timestampInt)
        
        debugPrint(">>> didUpdateRelativeLocation MistPoint = x=\(relativeLocation.x) y=\(relativeLocation.y)")
        
        let beaconPoint = BeaconPoint(uuid_mobile: mobileUUID, language: language, host: "", platform: platform, manufactur: manufactur, model: model, os: osVersion, latitude_x: "\(relativeLocation.x)", longitude_y: "\(relativeLocation.y)", timestamp: timestampString)
        
        DataBaseManager.shared.addData(beaconPoint: beaconPoint)
        
        shouldApiCall()
    }

    func didReceivedOrgInfo(withTokenName tokenName: String!, andOrgID orgID: String!) {
        debugPrint(">>> didReceivedOrgInfo tokenName = \(tokenName.description) orgID = \(orgID.description)")
    }

    func didErrorOccur(with errorType: ErrorType, andMessage errorMessage: String!) {
        debugPrint(">>> didErrorOccur errorType = \(errorType.rawValue) errorMessage = \(errorMessage.description)")
    }
}

extension AeroAccess: VirtualBeaconsDelegate {
    func didRangeVirtualBeacon(_ mistVirtualBeacon: MistVirtualBeacon!) {
        let mobileUUID = UIDevice.current.identifierForVendor
        let mistUUID = UUID(uuidString: mistVirtualBeacon.vbID)
        let timestamp = NSDate().timeIntervalSince1970
        let timestampInt = Int(timestamp)
        let timestampString = String(timestampInt)
        
        let virtualBeacon = VirtualBeacon(uuid_mobile: mobileUUID, uuid_mist_analytics: mistUUID, zone_name: mistVirtualBeacon.name, zone_id: mistVirtualBeacon.vbUUID, org_id: mistVirtualBeacon.orgID, timestamp: timestampString)
        debugPrint(">>> didRangeVirtualBeacon MistVirtualBeacon.name = \(mistVirtualBeacon.name.description)")
        
        DataBaseManager.shared.addData(virtualBeacon: virtualBeacon)
    }
    
    func didUpdateVirtualBeaconList(_ mistVirtualBeacons: [MistVirtualBeacon]!) {
        debugPrint(">>> didUpdateVirtualBeaconList mistVirtualBeacons = \(mistVirtualBeacons.count)")
    }
}

extension AeroAccess: ZonesDelegate {
    func didEnter(_ mistZone: MistZone!) {
        let mobileUUID = UIDevice.current.identifierForVendor
        let timestamp = NSDate().timeIntervalSince1970
        let timestampInt = Int(timestamp)
        let timestampString = String(timestampInt)
        
        let beaconZone = BeaconZone(uuid_mobile: mobileUUID, zone_name: mistZone.name, zone_id: mistZone.zoneID, org_id: mistZone.orgID, timestamp: timestampString)
        debugPrint(">>> didEnter MistZone name = \(mistZone.name.description) ID = \(mistZone.zoneID.description)")
        
        DataBaseManager.shared.addData(beaconZone: beaconZone)
        
//        shouldApiCall()
    }
    
    func didExitZone(_ mistZone: MistZone!) {
        debugPrint(">>> didExitZone MistZone name = \(mistZone.name.description) ID = \(mistZone.zoneID.description)")
    }
}

extension AeroAccess: MapsListDelegate {
    func didReceiveAllMaps(_ maps: [MistMap]!) {
        debugPrint(">>> didReceiveAllMaps maps = \(maps.count)")
    }
}

#endif
