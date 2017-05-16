//
//  ViewController.swift
//  snapchat
//
//  Created by Brian Benjamin Pareja Meruvia on 15/05/17.
//  Copyright © 2017 Brian Benjamin Pareja Meruvia. All rights reserved.
//

import UIKit
import Firebase

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
        
        FIRAuth.auth()?.signIn(withEmail: email.text!, password: password.text!, completion:{ (user,error) in
            print("Intentamos iniciar Sesion")
            if error != nil{
//                print("TENEMOS EL SIGUIENTE ERROR: \(error)")
                FIRAuth.auth()?.createUser(withEmail: self.email.text!, password: self.password.text!, completion:{ (user,error) in
                        print("Intentamos crear un usuario")
                    if error != nil{
                            print("TENEMOS EL SIGUIENTE ERROR: \(error)")
                    }
                    else{
                            print("Inicio de Sesion exitoso")
                        self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                    }
                })
            }else{
                    print("Inicio de Sesion exitoso")
                    self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                }
            })
    }
}
