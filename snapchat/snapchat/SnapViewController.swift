//
//  SnapViewController.swift
//  snapchat
//
//  Created by Brian Benjamin Pareja Meruvia on 22/05/17.
//  Copyright © 2017 Brian Benjamin Pareja Meruvia. All rights reserved.
//

import UIKit
import Firebase

class SnapViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var snaps : [Snap] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        FIRDatabase.database().reference().child("usuarios").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").observe(FIRDataEventType.childAdded, with: {(snapshot) in
            let snap = Snap()
            
            
            snap.imagenURL = (snapshot.value as! NSDictionary)["imagenURL"] as! String
            snap.from = (snapshot.value as! NSDictionary)["from"] as! String
            snap.descrip = (snapshot.value as! NSDictionary)["descripcion"] as! String
            self.snaps.append(snap)
            self.tableView.reloadData()
    })
}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snaps.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let snap = snaps[indexPath.row]
        cell.textLabel?.text = snap.from
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = snaps[indexPath.row]
        performSegue(withIdentifier: "versnapsegue", sender: snap)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "versnapsegue"{
            let siguienteVC = segue.destination as! VerSnapViewController
            siguienteVC.snap = sender as! Snap
        }
    }
    
    
}
