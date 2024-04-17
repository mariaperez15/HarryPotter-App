//
//  FavoritosViewController.swift
//  HarryPotter
//
//  Created by María Pérez  on 16/4/24.
//

import UIKit

class FavoritosViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var searchbarFavoritos: UITextField!
    @IBOutlet weak var tablaFavoritos: UITableView!
    
    // MARK: - Variables
    var harryPotterManager: HarryPotterManager! = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //registrar nueva celda
        tablaFavoritos.register(UINib(nibName: "FavoritosTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        harryPotterManager = HarryPotterManager(container: appDelegate.persistentContainer)

        harryPotterManager.delegado = self
        
        tablaFavoritos.delegate = self
        tablaFavoritos.dataSource = self
        
        //metodo para buscar en la lista
        harryPotterManager.imprimirPersonajesFavoritos()
    }

}

// MARK: - Delegado HarryPotter
extension FavoritosViewController: harryPotterManagerDelegado{
    func mostrarPersonajesHarryPotter(lista: [Personaje]) {

    }
}

// MARK: - Tabla
extension FavoritosViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaFavoritos.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! FavoritosTableViewCell
        celda.nameFavorito.text = "Favoritos"
        celda.genderFavorito.text = "Fav"
        celda.houseFavorito.text = "Fav"
        celda.imagenFavorito.image = UIImage(named: "HarryPotter")
        
        //celda imagen desde URL
        
        return celda
    }
       
   }
