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
import AVFoundation

class VerSnapViewController: UIViewController {


    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    var audioPlayer : AVAudioPlayer?
    
    var snap = Snap()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        label.text? = snap.descrip
        image.sd_setImage(with: URL(string: snap.imagenURL))
    }
    @IBAction func playTapped(_ sender: UIButton) {
        var player = AVPlayer()
        do{
            let url = URL(string: snap.audioURL)
//            var url = snap.audioURL
            player = AVPlayer(url:url!)
            
            let playerLayer = AVPlayerLayer(player: player)
            
            playerLayer.frame = self.view.bounds
            self.view.layer.addSublayer(playerLayer)
            
            player.play()
        }
        
        catch{}

    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        FIRDatabase.database().reference().child("usuarios").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").child(snap.id).removeValue()
        
        FIRStorage.storage().reference().child("imagenes").child("\(snap.imagenID).jpg").delete{(error) in
            print("se elimino la imagen")
        }
        
        FIRStorage.storage().reference().child("audio").child("\(snap.imagenID).jpg").delete{(error) in
            print("se elimino el audio")
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
