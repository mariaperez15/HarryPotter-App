//
//  FavoritosViewController.swift
//  HarryPotter
//
//  Created by María Pérez  on 16/4/24.
//

import UIKit

class FavoritosViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tablaFavoritos: UITableView!
    
    // MARK: - Variables
    var harryPotterManager: HarryPotterManager!
    var personajesFavoritos: [PersonajeFavorito] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Registrar nueva celda
        tablaFavoritos.register(UINib(nibName: "FavoritosTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoritosTableViewCell")
        
        // Establecer el dataSource de la tabla
        tablaFavoritos.dataSource = self
        
        // Cargar los personajes favoritos al cargar la vista
        cargarPersonajesFavoritos()
    }
    
    // Función para cargar los personajes favoritos
    func cargarPersonajesFavoritos() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let harryPotterManager = HarryPotterManager(container: appDelegate.persistentContainer)
            self.personajesFavoritos = harryPotterManager.recuperarPersonajesFavoritos()
            self.tablaFavoritos.reloadData()
        }
    }
}

// MARK: - Tabla
extension FavoritosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(personajesFavoritos.count)

        
        return personajesFavoritos.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaFavoritos.dequeueReusableCell(withIdentifier: "FavoritosTableViewCell", for: indexPath) as! FavoritosTableViewCell
        
        let personajeFavorito = personajesFavoritos[indexPath.row]
        
        celda.nameFavorito.text = personajeFavorito.name ?? ""
        celda.genderFavorito.text = "Gender: \(personajeFavorito.gender ?? "")"
        celda.houseFavorito.text = "House: \(personajeFavorito.house ?? "")"
        
        if let imageName = personajeFavorito.image, let image = UIImage(named: imageName) {
            celda.imagenFavorito.image = image
        } else {
            // Si no hay una imagen disponible, puedes asignar una imagen predeterminada o dejarla en blanco
            celda.imagenFavorito.image = UIImage(named: "imagen_predeterminada")
        }
        
        
        //if let imageData = personaje.image {
        //    if let image = UIImage(data: imageData) {
        //        celda.imagenFavorito.image = image
         //   }
        //}
        
        
        return celda
    }
}
