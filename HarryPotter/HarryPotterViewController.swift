//
//  ViewController.swift
//  HarryPotter
//
//  Created by María Pérez  on 4/4/24.
//

import UIKit

protocol harryPotterManagerDelegado {
    func mostrarPersonajesHarryPotter(lista: [Personaje])
}

class HarryPotterViewController: UIViewController {
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var searchPersonajeTextField: UITextField!
    @IBOutlet weak var tablaHarryPotter: UITableView!
    
    // MARK: - Variables
    var harryPotterManager: HarryPotterManager! = nil
    
    var personajes: [Personaje] = []
    
    var personajeSeleccionado : Personaje?
    
    var personajesFilrados: [Personaje] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //registrar nueva celda
        tablaHarryPotter.register(UINib(nibName: "CeldaPersonajeTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            harryPotterManager = HarryPotterManager(container: appDelegate.persistentContainer)
        }
        
        harryPotterManager.delegado = self
        searchPersonajeTextField.delegate = self
        
        tablaHarryPotter.delegate = self
        tablaHarryPotter.dataSource = self
        
        //Ejecutar el metodo para buscar la lista de personajes
        harryPotterManager.verPersonajes()
        
        personajesFilrados = personajes
    }
}

// MARK: - Textfield as SearchBar
extension HarryPotterViewController : UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        personajesFilrados = []
        
        if textField.text == "" {
            personajesFilrados = personajes
        } else {
            for person in personajes {
                if person.name.lowercased().contains(textField.text!) {
                    personajesFilrados.append(person)
                }
            }
        }
        self.tablaHarryPotter.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Ocultar el teclado
        textField.endEditing(true)
        return true
    }
}

// MARK: - Delegado Harry Potter
extension HarryPotterViewController: harryPotterManagerDelegado {
    func mostrarPersonajesHarryPotter(lista: [Personaje]) {
        personajes = lista
        
        DispatchQueue.main.async {
            self.personajesFilrados = lista
            self.tablaHarryPotter.reloadData()
        }
    }
    
    
}

// MARK: - Tabla
extension HarryPotterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personajesFilrados.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaHarryPotter.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! CeldaPersonajeTableViewCell
        
        celda.nombrePersonaje.text = personajesFilrados[indexPath.row].name
        celda.genderPersonaje.text = "Gender: \(personajesFilrados[indexPath.row].gender)"
        celda.housePersonaje.text =  "House: \(personajesFilrados[indexPath.row].house)"
        celda.favoriteButton.tag = indexPath.row
        celda.favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped(_:)), for: .touchUpInside)

        
        
        //celda imagen desde URL
        if let urlString = personajesFilrados[indexPath.row].image as? String {
            if let imageURL = URL(string: urlString) {
                DispatchQueue.global().async {
                    guard let imagenData = try? Data(contentsOf: imageURL) else 
                        { return }
                    let image = UIImage(data: imagenData)
                    DispatchQueue.main.async {
                        celda.imagenPersonaje.image = image
                    }
                }
            }
        }
        
        
        return celda
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        personajeSeleccionado = personajesFilrados[indexPath.row]
        
        performSegue(withIdentifier: "verPersonajes", sender: self)
        
        //Deseleccionar
        tablaHarryPotter.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verPersonajes" {
            let verPersonajes = segue.destination as! DetallePersonajeViewController
            verPersonajes.personajeMostrar = personajeSeleccionado
        }
    }
 
    
    @objc func favoriteButtonTapped(_ sender: UIButton) {
        print("Botón de favorito presionado")
            // Obtiene el índice de la celda en la que se encuentra el botón
            let indexPath = IndexPath(row: sender.tag, section: 0)
            
            // Obtiene el personaje correspondiente al índice
            let personaje = personajesFilrados[indexPath.row]
            
            // Llama a la función para guardar el personaje como favorito
            harryPotterManager.guardarPersonajeFavorito(personaje)
        
        harryPotterManager.imprimirPersonajesFavoritos()
        
        }
    
    

}
