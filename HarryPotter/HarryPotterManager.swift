//
//  HarryPotterManager.swift
//  HarryPotter
//
//  Created by María Pérez  on 4/4/24.
//

import Foundation

protocol harryPotterManagerDelegado {
    func mostrarPersonajesHarryPotter(lista: [Personaje])
}

struct HarryPotterManager {
    var delegado: harryPotterManagerDelegado?
    
    func verPersonajes() {
        let urlString = "https://hp-api.onrender.com/api/characters"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let tarea = session.dataTask(with: url) { datos, respuesta, error in
                if error != nil {
                    print("Error al obtener datos de la API: ",error?.localizedDescription)
                }
                
                if let datosSeguros = datos {
                    if let listaPersonajes = self.parsearJSON(datosPersonajes: datosSeguros) {
                        print("Lista personajes: ", listaPersonajes)
                        
                        delegado?.mostrarPersonajesHarryPotter(lista: listaPersonajes)
                    }
                }
            }
            tarea.resume()
        }
    }
    
    func parsearJSON(datosPersonajes: Data) -> [Personaje]? {
        let decodificador = JSONDecoder()
        do {
            let datosDecodificados = try decodificador.decode([Personaje].self, from: datosPersonajes)
            
            return datosDecodificados
            
        } catch {
            print("Error al decodificar los datos: ", error.localizedDescription)
            return nil
        }
    }
}
