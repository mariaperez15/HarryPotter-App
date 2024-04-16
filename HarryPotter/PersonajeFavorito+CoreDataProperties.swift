//
//  PersonajeFavorito+CoreDataProperties.swift
//  
//
//  Created by María Pérez  on 16/4/24.
//
//

import Foundation
import CoreData


extension PersonajeFavorito {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonajeFavorito> {
        return NSFetchRequest<PersonajeFavorito>(entityName: "PersonajeFavorito")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var house: String?
    @NSManaged public var image: String?
    @NSManaged public var gender: String?
    @NSManaged public var species: String?
    @NSManaged public var ancestry: String?
    @NSManaged public var actor: String?

}
