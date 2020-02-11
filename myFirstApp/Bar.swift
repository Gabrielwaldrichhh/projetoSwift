//
//  Bar.swift
//  myFirstApp
//
//  Created by Catarinense de Blumenau on 03/02/20.
//  Copyright © 2020 HBSIS. All rights reserved.
//ä
import UIKit
import os.log

class Bar : NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: PropertyKey.name)
    aCoder.encode(photo, forKey: PropertyKey.photo)
    aCoder.encode(rating, forKey: PropertyKey.rating)
    aCoder.encode(telefone,forKey: PropertyKey.telefone)
    aCoder.encode(endereco,forKey: PropertyKey.endereco)
    }
    
    required convenience init?(coder aDecoder: NSCoder)  {
        
        // The name is requiraed. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        let telefone = aDecoder.decodeObject(forKey: PropertyKey.telefone)
        
        let endereco = aDecoder.decodeObject(forKey: PropertyKey.endereco)
        
        // Must call designated initializer.
        
        self.init(name: name, rating: rating, endereco : endereco as!
            String, telefone : telefone as! String, photo: photo)
        
    }
    
    
    //MARK: Properties
    
    var name: String = ""
    var rating: Int = 0
    var endereco: String = ""
    var telefone: String = ""
    var photo: UIImage?
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("Bares")

    
    //MARK Types
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
        static let telefone = "telefone"
        static let endereco = "endereco"
    }


    //MARK: Initialization

    init?(name: String, rating: Int, endereco: String, telefone: String, photo: UIImage?) {
    

        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        guard !endereco.isEmpty else {
            return nil
        }
        
        guard !(telefone.count == 11) else {
            return nil
        }

    // Initialize stored properties.

self.name = name
self.rating = rating
self.endereco = endereco
self.telefone = telefone
self.photo = photo
    
    }

    
}
