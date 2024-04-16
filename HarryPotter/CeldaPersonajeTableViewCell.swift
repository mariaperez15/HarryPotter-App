//
//  CeldaPersonajeTableViewCell.swift
//  HarryPotter
//
//  Created by María Pérez  on 4/4/24.
//

import UIKit

class CeldaPersonajeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var genderPersonaje: UILabel!
    @IBOutlet weak var housePersonaje: UILabel!
    @IBOutlet weak var imagenPersonaje: UIImageView!
    @IBOutlet weak var nombrePersonaje: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imagenPersonaje.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
