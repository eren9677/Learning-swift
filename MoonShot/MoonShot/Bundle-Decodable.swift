//
//  Bundle-Decodable.swift
//  MoonShot
//
//  Created by eren on 17.09.2024.
//

import Foundation
//this file will create an extension to the bundle struct this will both load the bundle and the decode it's information.
// the astronauts.json and missions.json has information and needs to be loaded before decoding. lets handle that in a bundle
extension Bundle {
    func decode<GenericTypeeee: Codable>( _ file: String) -> GenericTypeeee{
        guard let url = Bundle.main.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file). ")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Data in \(file) is corrupted or can't be accessed.")
        }
        
        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode(GenericTypeeee.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON.")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}
