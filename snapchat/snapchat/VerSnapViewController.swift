//
//  VerSnapViewController.swift
//  snapchat
//
//  Created by Brian Benjamin Pareja Meruvia on 22/05/17.
//  Copyright © 2017 Brian Benjamin Pareja Meruvia. All rights reserved.
//

import UIKit

class VerSnapViewController: UIViewController {


    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var snap = Snap()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        label.text? = snap.descrip
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
