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
                self.delegado?.mostrarPersonajesFavoritos(lista: personajes)
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
        personajeFavorito.image = personaje.image
        
        do {
            try context.save()
            print("Personaje favorito '\(personaje.name)' guardado exitosamente")
        } catch {
            print("Error al guardar el personaje favorito: \(error.localizedDescription)")
        }
    }
    
    
    func eliminarPersonajeFavorito(withId id: String) {
        let context = persistentContainer.viewContext
        
        // Recupera todos los personajes favoritos con el ID proporcionado
        let personajesFavoritos = recuperarPersonajesFavoritos(withId: id)
        
        // Elimina cada personaje favorito del contexto
        for personajeFavorito in personajesFavoritos {
            context.delete(personajeFavorito)
        }
        
        // Guarda los cambios en el contexto
        do {
            try context.save()
            print("Personajes favoritos eliminados exitosamente")
        } catch {
            print("Error al eliminar los personajes favoritos: \(error.localizedDescription)")
        }
    }
    
    

    func recuperarPersonajesFavoritos(withId id: String? = nil) -> [PersonajeFavorito] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<PersonajeFavorito> = PersonajeFavorito.fetchRequest()
        
        // Si se proporciona un ID, se agrega un predicado para filtrar por ese ID
        if let id = id {
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        }
        
        do {
            let personajesFavoritos = try context.fetch(fetchRequest)
            
            print("Personajes en favoritos:")
            for personajeFavorito in personajesFavoritos {
                if let name = personajeFavorito.name {
                    print("Nombre: \(name)")
                }                
                if let gender = personajeFavorito.gender {
                    print(gender)
                }
                if let image = personajeFavorito.image {
                    print(image)
                }

            }
            print("------")
            print(personajesFavoritos)
            
            return personajesFavoritos
            
        } catch {
            print("Error al recuperar los personajes favoritos: \(error.localizedDescription)")
            return []
        }
    }

    
    
    func imprimirPersonajesFavoritos() {
        let personajesFavoritos = recuperarPersonajesFavoritos()
        
        print("Personajes en favoritos: ")
        for personajeFavorito in personajesFavoritos {
            print("Nombre: \(personajeFavorito.name)")

        }
        print("------")
    }
    
    
}
