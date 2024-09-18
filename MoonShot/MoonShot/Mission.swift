//
//  Mission.swift
//  MoonShot
//
//  Created by eren on 18.09.2024.
//

import Foundation




struct Mission : Codable, Identifiable {
    struct CrewRole: Codable{
        let name: String
        let role: String
    }
    let id : Int
    let launch : String? //this part is optional because one of the missions has no launch date information!
    let crew: [CrewRole]
    let description: String
    
    var name: String {
        "Apollo \(id)"
    }
    var image: String {
        "apollo\(id)"
    }
}
