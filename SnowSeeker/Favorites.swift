//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Radu Petrisel on 03.08.2023.
//

import Foundation

final class Favorites: ObservableObject {
    private static let resortsKey = "resorts"
    private(set) var resorts: Set<String>
    
    init() {
        // load from UserDefaults
        resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        // save to UserDefaults
    }
}
