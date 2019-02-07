//
//  ViewController.swift
//  Bip The Guy
//
//  Created by Christopher Knapp on 2/3/19.
//  Copyright © 2019 Christopher Knapp. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        imageToPunch.image = selectedImage
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func playSound(soundName: String, audioPlayer: inout AVAudioPlayer){
        if let sound = NSDataAsset(name: soundName) {
            do{
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print("ERROR: Data in \(soundName) could not be played")
            }
        } else {
            print("ERROR: file\(soundName) didn't load")
        }
    }
    @IBOutlet weak var imageToPunch: UIImageView!
   
    var audioPlayer = AVAudioPlayer()
    var imagePicker = UIImagePickerController()
   
    override func viewDidLoad() {
        super.viewDidLoad()}
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func animateImage() {
        let bounds = self.imageToPunch.bounds
        self.imageToPunch.bounds = CGRect(x: self.imageToPunch.bounds.origin.x + 60, y: self.imageToPunch.bounds.origin.y + 60, width: self.imageToPunch.bounds.size.width - 60, height: self.imageToPunch.bounds.size.height - 60)

    
        
        UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: [], animations: {self.imageToPunch.bounds = bounds}, completion: nil)
    }
    
    @IBAction func libraryPressed(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraPressed(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        } else {
            showAlert(title: "Camera Not Available", message: "There is no camera available on this device.")
        }
    }
    
    @IBAction func imagePressed(_ sender: UITapGestureRecognizer) {
        animateImage()
        playSound(soundName: "punchSound", audioPlayer: &audioPlayer)
    }
    
}


