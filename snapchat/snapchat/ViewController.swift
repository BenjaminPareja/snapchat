//
//  ViewController.swift
//  snapchat
//
//  Created by Brian Benjamin Pareja Meruvia on 15/05/17.
//  Copyright © 2017 Brian Benjamin Pareja Meruvia. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnIniciarSesion(_ sender: Any) {
        
        if "hols" != nil{
            print("TENEMOS EL SIGUIENTE ERROR: \(error)")
        }
        else{
            print("Inicio de Sesion exitoso")
        }
    }


}

