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
        
        // Configurar el mensaje de "No hay personajes favoritos" si no hay personajes favoritos
        configureNoDataLabelIfNeeded()
        

    }
    
    func configureNoDataLabelIfNeeded() {
        if personajesFavoritos.isEmpty {
            configureNoDataLabel()
            tablaFavoritos.tableHeaderView?.isHidden = false
        } else {
            tablaFavoritos.tableHeaderView?.isHidden = true
        }
    }
    
    func configureNoDataLabel() {
        let messageLabel = UILabel(frame: CGRect(x: 40, y: 140, width: tablaFavoritos.bounds.size.width, height: tablaFavoritos.bounds.size.height))
        messageLabel.text = "Todavía no hay personajes favoritos"
        messageLabel.textColor = UIColor.gray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 20)
        messageLabel.sizeToFit()

        

        view.addSubview(messageLabel)
    }

    
    // Función para cargar los personajes favoritos
    func cargarPersonajesFavoritos() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let harryPotterManager = HarryPotterManager(container: appDelegate.persistentContainer)
            self.personajesFavoritos = harryPotterManager.recuperarPersonajesFavoritos()
            self.tablaFavoritos.reloadData()
            
            // Configurar el mensaje de "No hay personajes favoritos" si no hay personajes favoritos
            configureNoDataLabelIfNeeded()
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
        
        if(personajesFavoritos.count < 1){
            configureNoDataLabel()
            tablaFavoritos.tableHeaderView?.isHidden = false
        } else {
            tablaFavoritos.tableHeaderView?.isHidden = true
        }
        
            let personajeFavorito = personajesFavoritos[indexPath.row]
            celda.nameFavorito.text = personajeFavorito.name ?? ""
            celda.genderFavorito.text = "Gender: \(personajeFavorito.gender ?? "")"
            celda.houseFavorito.text = "House: \(personajeFavorito.house ?? "")"

        
        return celda
    }
}
