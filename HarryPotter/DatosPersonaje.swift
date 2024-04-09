//
//  DatosPersonajes.swift
//  HarryPotter
//
//  Created by María Pérez  on 4/4/24.
//

import Foundation

struct Personaje: Decodable, Identifiable {
    let id: String
    let name: String
    let house: String
    let image: String
    let gender: String
    let species: String
    let ancestry: String
    let actor: String
}
