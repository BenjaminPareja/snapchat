//
//  VerSnapViewController.swift
//  snapchat
//
//  Created by Brian Benjamin Pareja Meruvia on 22/05/17.
//  Copyright © 2017 Brian Benjamin Pareja Meruvia. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase
class VerSnapViewController: UIViewController {


    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var snap = Snap()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        label.text? = snap.descrip
        image.sd_setImage(with: URL(string: snap.imagenURL))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        FIRDatabase.database().reference().child("usuarios").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").child(snap.id).removeValue()
        
        FIRStorage.storage().reference().child("imagenes").child("\(snap.imagenID).jpg").delete{(error) in
            print("se elimino")
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
