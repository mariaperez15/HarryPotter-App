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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tablaFavoritos.delegate = self
        tablaFavoritos.dataSource = self
    }

}

// MARK: - Tabla
extension FavoritosViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaFavoritos.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        celda.textLabel?.text = "Harry"
        return celda
    }
       
   }
