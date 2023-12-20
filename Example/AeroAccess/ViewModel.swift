//
//  ViewModel.swift
//  AeroAccess_Example
//
//  Created by Nemanja Cvetkovic on 19.12.23..
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import AeroAccess

class ViewModel {
    private var aeroAccessService: AeroAccessService?
    private var wakeUpService: WakeUpService?
    
    init() {
        self.aeroAccessService = AeroAccess(accessToken: "PlBZ2hlNo9ORjMEIlCfZF9kktiLHbODO")
        self.wakeUpService = WakeUp(orgId: "e19932cc-7771-42ee-9ece-f89a3cfd1ea1")
    }
    
    func start() {
        aeroAccessService?.start()
        wakeUpService?.start()
    }
    
    func stop() {
        aeroAccessService?.stop()
        wakeUpService?.stop()
    }
    
    func syncData() {
        aeroAccessService?.syncData()
    }
}

extension ViewModel: WakeUpDelegate {
    func didEnterRegion(region: String) {
        debugPrint(">>> didEnterRegion Beacon = \(region)")
        
        if aeroAccessService?.isStarted == false {
            aeroAccessService?.start()
        }
    }
    
    func didExitRegion(region: String) {
        debugPrint(">>> didExitRegion Beacon = \(region)")
    }
}
