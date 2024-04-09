//
//  DetallePersonajeViewController.swift
//  HarryPotter
//
//  Created by María Pérez  on 8/4/24.
//

import UIKit

class DetallePersonajeViewController: UIViewController {
    
    // MARK: - Variables
    var personajeMostrar: Personaje?
    
    // MARK: - IBOutlets
    @IBOutlet weak var ancestryPersonaje: UILabel!
    @IBOutlet weak var speciesPersonaje: UILabel!
    @IBOutlet weak var housePersonaje: UILabel!
    @IBOutlet weak var actor: UILabel!
    @IBOutlet weak var genderPersonaje: UILabel!
    @IBOutlet weak var namePersonaje: UILabel!
    @IBOutlet weak var imagenPersonaje: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //imagen mostrar
        imagenPersonaje.loadFrom(URLAddres: personajeMostrar?.image ?? "")
        namePersonaje.text = "\(personajeMostrar?.name ?? "")"
        genderPersonaje.text = "Gender: \(personajeMostrar?.gender ?? "")"
        actor.text = "Actor: \(personajeMostrar?.actor ?? "")"
        housePersonaje.text = "House: \(personajeMostrar?.house ?? "")"
        speciesPersonaje.text = "Species: \(personajeMostrar?.species ?? "")"
        ancestryPersonaje.text = "Ancestry: \(personajeMostrar?.ancestry ?? "")"
                
    }

}


extension UIImageView {
    func loadFrom(URLAddres: String) {
        guard let url = URL(string: URLAddres) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data,
                  let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }
        .resume()
    }
}
