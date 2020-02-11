//
//  ViewController.swift
//  myFirstApp
//
//  Created by Blumenauense de Blumenau on 28/01/20.
//  Copyright © 2020 HBSIS. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    
    @IBOutlet weak var RatingBar: RatingBar!
    var bar: Bar?
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var nomeBar: UITextField!
    @IBOutlet weak var enderecoBar: UITextField!
    
    @IBOutlet weak var telefoneBar: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        nomeBar.delegate = self
        
        // Set up views if editing an existing Meal.
        if let bar = bar {
            nomeBar.text = bar.name
            RatingBar.rating = bar.rating
            imagem.image = bar.photo
            enderecoBar.text = bar.endereco
            telefoneBar.text = bar.telefone
        }
        
        // Enable the Save button only if the text field has a valid Meal name.
        updateSaveButtonState()
    
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        var nomeCampo : String!
        if(textField == nomeBar) {
            nomeCampo = "Bar: "
        } else {
            if (textField == enderecoBar) {
                nomeCampo = "Endereco: "
            } else {
                if (textField == telefoneBar) {
                    nomeCampo = "Telefone: "
                }
            }
        }
        
        let digitado = textField.text!
        let message = nomeCampo! + digitado
        print(message)
        
        return true;
}
    
    
    @IBAction func cancel(_ sender: Any) {
         dismiss(animated: true, completion: nil)
        
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            
            dismiss(animated: true, completion: nil)
            
        } else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        } else {
            fatalError("The ViewController is not inside a navigation controller.")
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        print("Bar:" + nomeBar.text!)
        print("Endereço: " + enderecoBar.text!)
        print("Telefone: " + telefoneBar.text!)
    }
    
    //MARK: Navigation
    

    
    // This method lets you configure a view controller before it's presented.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nomeBar.text ?? ""
        let rating = RatingBar.rating
        let endereco = enderecoBar.text  ?? ""
        let telefone = telefoneBar.text ?? ""
        let photo = imagem.image
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        bar = Bar(name: name, rating: rating, endereco: endereco, telefone: telefone, photo: photo)
    }
    
    @IBAction func Imagem(_ sender: Any) {
    
    
        func showAlert() {
            
            let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
                self.getImage(fromSourceType: .camera)
            }))
            alert.addAction(UIAlertAction(title: "Carregar da galeria", style: .default, handler: {(action: UIAlertAction) in
                self.getImage(fromSourceType: .photoLibrary)
            }))
            alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        showAlert();
    }
    
    func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage;
        imagem.image = image
        picker.dismiss(animated: true , completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
 
    //MARK: Private Methods
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = nomeBar.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
}
