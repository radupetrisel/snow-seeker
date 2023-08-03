//
//  Resort.swift
//  SnowSeeker
//
//  Created by Radu Petrisel on 03.08.2023.
//

import Foundation

struct Resort: Identifiable, Codable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init(name:))
    }
    
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let preview = allResorts.first!
}
