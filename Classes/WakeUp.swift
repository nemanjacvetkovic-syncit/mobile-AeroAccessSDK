//
//  WakeUp.swift
//  Pods
//
//  Created by Nemanja Cvetkovic on 29.11.23..
//

import Foundation
import CoreLocation

public protocol WakeUpService {
    var isWakeUpRuning: Bool { get }
    public func start()
    public func stop()
}

public protocol WakeUpDelegate: AnyObject {
    func didEnterRegion(region: String)
    func didExitRegion(region: String)
}

class WakeUp: NSObject {
    weak var delegate: WakeUpDelegate?
    
    private lazy var locationManager = CLLocationManager()
    private let orgId: String
    
    var isWakeUpRuning: Bool = false
    
    init(orgId: String) {
        self.orgId = orgId
        super.init()
        setUpLocationManager()
    }
    
    private func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func startMonitoringBeaconRegion() {
        guard let orgUUID = UUID(uuidString: orgId) else {
            debugPrint(">> Please enter a valid org_id")
            return
        }
        
        var beaconUUIDs = [String]()
        
        beaconUUIDs.append(orgUUID.uuidString)
        
        let shortUUID = orgUUID.uuidString.shortOrgUUIDString
        let beaconHexValues = ["a", "b", "c", "d", "e", "f"]
        let numOfCyclicalBeacons = 3
        
        for i in 0..<numOfCyclicalBeacons {
            if i < 10 {
                let beaconUUID = String(format: "%@%d", shortUUID, i)
                beaconUUIDs.append(beaconUUID)
            } else if i < 16 {
                let beaconUUID = String(format: "%@%@", shortUUID, beaconHexValues[i-10])
                beaconUUIDs.append(beaconUUID)
            } else {
                let beaconUUID = String(format: "%@%d", shortUUID, i-6)
                beaconUUIDs.append(beaconUUID)
            }
        }
        
        for (index, beaconUUID) in beaconUUIDs.enumerated() {
            guard let beaconUUID =  UUID(uuidString: beaconUUID) else { return }
            let beaconName = "Juniper_Mist_AP_Beacon_\(index)"
            let beaconRegion = CLBeaconRegion.create(with: beaconName, uuid: beaconUUID)
            locationManager.startMonitoring(for: beaconRegion)
            
            debugPrint(">> Start Monitoring Beacon = \(beaconRegion.identifier.description), proximityUUID = \(beaconRegion.uuid.uuidString), major = \(beaconRegion.major?.stringValue ?? "") minor = \(beaconRegion.minor?.stringValue ?? "")")
        }
        
        isWakeUpRuning = true
    }
    
    private func stopMonitoringBeaconRegion() {
        for region in locationManager.monitoredRegions {
            guard let beaconRegion = region as? CLBeaconRegion else { continue }
            locationManager.stopMonitoring(for: beaconRegion)
            
            isWakeUpRuning = false
            
            debugPrint(">> Stop Monitoring Beacon = \(beaconRegion.identifier.description), proximityUUID = \(beaconRegion.uuid.uuidString), major = \(beaconRegion.major?.stringValue ?? "") minor = \(beaconRegion.minor?.stringValue ?? "")")
        }
    }
}

extension WakeUp: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        delegate?.didEnterRegion(region: region.identifier)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        delegate?.didExitRegion(region: region.identifier)
    }
}

extension WakeUp: WakeUpService {
    
    public func start() {
        startMonitoringBeaconRegion()
    }
    
    public func stop() {
        stopMonitoringBeaconRegion()
    }
}

extension CLBeaconRegion {
    static func create(with name: String, uuid: UUID) -> CLBeaconRegion {
        let beaconRegion = CLBeaconRegion(uuid: uuid, identifier: name)
        beaconRegion.notifyOnEntry = true
        beaconRegion.notifyOnExit = true
        beaconRegion.notifyEntryStateOnDisplay = true
        return beaconRegion
    }
}
