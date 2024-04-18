//
//  FavoritosTableViewCell.swift
//  HarryPotter
//
//  Created by María Pérez  on 17/4/24.
//

import UIKit

class FavoritosTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var genderFavorito: UILabel!
    @IBOutlet weak var nameFavorito: UILabel!
    @IBOutlet weak var houseFavorito: UILabel!
    

    //override func awakeFromNib() {
      //  super.awakeFromNib()
      //  imagenFavorito.layer.cornerRadius = 15
    //}
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
