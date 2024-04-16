//
//  HarryPotterManager.swift
//  HarryPotter
//
//  Created by María Pérez  on 4/4/24.
//

import Foundation
import CoreData
import Alamofire

struct HarryPotterManager {
    var delegado: harryPotterManagerDelegado?
    
    let persistentContainer: NSPersistentContainer
    
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
    }
    
    func verPersonajes() {
        let urlString = "https://hp-api.onrender.com/api/characters"
        
        AF.request(urlString).responseDecodable(of: [Personaje].self) { response in
            switch response.result {
            case .success(let personajes):
                self.delegado?.mostrarPersonajesHarryPotter(lista: personajes)
            case .failure(let error):
                print("Error al obtener datos de la API: ", error.localizedDescription)
            }
        }
    }
    
    func guardarPersonajeFavorito(_ personaje: Personaje) {
        let context = persistentContainer.viewContext
        
        let personajeFavorito = PersonajeFavorito(context: context)
        personajeFavorito.id = personaje.id
        personajeFavorito.name = personaje.name
        personajeFavorito.house = personaje.house
        personajeFavorito.actor = personaje.actor
        personajeFavorito.ancestry = personaje.ancestry
        personajeFavorito.gender = personaje.gender
        personajeFavorito.species = personaje.species
        
        do {
            try context.save()
            print("Personaje favorito '\(personaje.name)' guardado exitosamente")
        } catch {
            print("Error al guardar el personaje favorito: \(error.localizedDescription)")
        }
    }

    func recuperarPersonajesFavoritos() -> [PersonajeFavorito] {
        let context = persistentContainer.viewContext
        
        do {
            let personajesFavoritos = try context.fetch(PersonajeFavorito.fetchRequest()) as? [PersonajeFavorito] ?? []
            return personajesFavoritos
        } catch {
            print("Error al recuperar los personajes favoritos: \(error.localizedDescription)")
            return []
        }
    }
    
    func imprimirPersonajesFavoritos() {
        let personajesFavoritos = recuperarPersonajesFavoritos()
        
        for personajeFavorito in personajesFavoritos {
            print("Nombre: \(String(describing: personajeFavorito.name))")
            print("Casa: \(String(describing: personajeFavorito.house))")
            // Imprime otros atributos según sea necesario
            
            print("------")
        }
    }
    
}
