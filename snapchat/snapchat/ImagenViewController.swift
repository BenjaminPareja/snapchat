//
//  ImagenViewController.swift
//  snapchat
//
//  Created by Brian Benjamin Pareja Meruvia on 15/05/17.
//  Copyright © 2017 Brian Benjamin Pareja Meruvia. All rights reserved.
//

import UIKit

class ImagenViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var descripcion: UITextView!
    @IBOutlet weak var btnElegir: UIButton!
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self

        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imagen.image = image
        imagen.backgroundColor = UIColor.clear
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnFoto(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
        
    }

    @IBAction func btnElegirContacto(_ sender: Any) {
        performSegue(withIdentifier: "seleccionarContactoSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let imagenesFolder
        
        imagenesFolder.child("imagenes.png").put(imagenData, metadata: nil, completion:{(metadata,error)in
            print("Intentando subirla")
            if error != nil{
                print("Ocurrio un error: ")
            })
    }
   

}
