//
//  ImagenViewController.swift
//  snapchat
//
//  Created by Brian Benjamin Pareja Meruvia on 15/05/17.
//  Copyright © 2017 Brian Benjamin Pareja Meruvia. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation

class ImagenViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var descripcion: UITextView!
    @IBOutlet weak var btnElegir: UIButton!
    var imagePicker = UIImagePickerController()
    var imagenID = NSUUID().uuidString
    var URLaudio: String = ""
//  audio
    @IBOutlet weak var btnGrabar: UIButton!
    @IBOutlet weak var btnReproducir: UIButton!
    var audioRecorder : AVAudioRecorder?
    var audioURL : URL?
    var audioPlayer : AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecorder()
        imagePicker.delegate = self
        btnElegir.isEnabled = false
        btnReproducir.isEnabled = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imagen.image = image
        imagen.backgroundColor = UIColor.clear
        btnElegir.isEnabled = true
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnFoto(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
        
    }

    @IBAction func btnElegirContacto(_ sender: Any) {
        btnElegir.isEnabled = false
        let imagenesFolder = FIRStorage.storage().reference().child("imagenes")
        let imagenData = UIImageJPEGRepresentation(imagen.image!, 0.1)!
        
        imagenesFolder.child("\(imagenID).jpg").put(imagenData, metadata: nil, completion:{(metadata,error)in
            print("Intentando subirla")
            if error != nil{
                print("Ocurrio un error: ")
            }
            else{
                self.performSegue(withIdentifier: "seleccionarContactoSegue", sender: metadata?.downloadURL()!.absoluteString)
            }
        })
        
//        subiendo el audio a firebase
        let audioFolder = FIRStorage.storage().reference().child("audio")
        let audioData = NSData(contentsOf: audioURL!)
        
        audioFolder.child("\(imagenID).m4a").put(audioData! as Data, metadata: nil, completion:{(metadata,error)in
            print("Intentando subirla")
            if error != nil{
                print("Ocurrio un error: ")
            }
            else{
                self.URLaudio = (metadata?.downloadURL()!.absoluteString)!
            }
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let siguienteVC = segue.destination as! ElegirUsuarioViewController
        siguienteVC.imagenURL = sender as! String
        siguienteVC.audioURL = URLaudio
        print(URLaudio)
        siguienteVC.descrip = descripcion.text!
        siguienteVC.imagenID = imagenID
        
}

//funciones del audio
    func setupRecorder(){
        do{
            //creando una sesion de audio
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            //Creando una direccion para el archivo de audio
            let basePath : String = NSSearchPathForDirectoriesInDomains(. documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath,"audio1.m4a"]
            audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            print("*****************")
            print(audioURL)
            print("*****************")
            //Crear opciones para el grabador de audio
            var settings : [String:AnyObject] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject?
            settings[AVSampleRateKey] = 44100.0 as AnyObject?
            settings[AVNumberOfChannelsKey] = 2 as AnyObject?
            
            //Crear el objeto de grabacios de audio
            audioRecorder = try AVAudioRecorder(url: audioURL!, settings: settings)
            audioRecorder!.prepareToRecord()
        } catch let error as NSError{
            print(error)
        }
    }
    
    @IBAction func recTapped(_ sender: UIButton) {
        
        if audioRecorder!.isRecording{
            audioRecorder?.stop()
            btnGrabar.setTitle("Record", for: .normal)
            btnReproducir.isEnabled = true
            
        }
        else{
            audioRecorder?.record()
            btnGrabar.setTitle("Stop", for: .normal)
        }
        
        
    }
    
    @IBAction func playTapped(_ sender: UIButton) {
        do{
            try audioPlayer = AVAudioPlayer(contentsOf: audioURL!)
            audioPlayer?.play()
        }
        catch{}
    }
    
    

}
