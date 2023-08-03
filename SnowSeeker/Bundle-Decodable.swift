//
//  Bundle-Decodable.swift
//  SnowSeeker
//
//  Created by Radu Petrisel on 03.08.2023.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not locate \(file) in Bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file) from Bundle.")
        }
        
        let jsonDecoder = JSONDecoder()
        
        guard let decoded = try? jsonDecoder.decode(T.self, from: data) else {
            fatalError("Could not decode \(file) from Bundle.")
        }
        
        return decoded
    }
}
