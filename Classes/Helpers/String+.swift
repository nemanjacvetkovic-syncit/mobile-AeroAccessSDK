//
//  String+.swift
//  Alamofire
//
//  Created by Nemanja Cvetkovic on 29.11.23..
//

import Foundation

extension String {
    var shortOrgUUIDString: String {
        let shortOrgId = String(self.dropLast(2))
        let orgUUIDString = String(format: "%@%@", shortOrgId, "0")
        return orgUUIDString
    }
}
