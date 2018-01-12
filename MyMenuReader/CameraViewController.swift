//
//  CameraViewController.swift
//  MyMenuReader
//
//  Created by xi zhang on 1/12/18.
//  Copyright © 2018 xi zhang. All rights reserved.
//

import UIKit

protocol CameraViewControllerDelegate: class {
    func cameraFlipButtonDidTapped(sender:UIButton)
    func cameraFromGalleryButtonDidTapped(sender:UIButton)
    func cameraCaptureButtonDidTapped(sender:UIButton)
    func cameraCancelButtonDidTapped(sender:UIButton)
}

class CameraViewController: UIViewController {

    weak var delegate:CameraViewControllerDelegate?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.delegate?.cameraCancelButtonDidTapped(sender: sender)
    }
    
    
    @IBAction func captureButtonAction(_ sender: UIButton) {
        self.delegate?.cameraCaptureButtonDidTapped(sender: sender)
    }
    
    
    @IBAction func fromGalleryButtonAction(_ sender: UIButton) {
        self.delegate?.cameraFromGalleryButtonDidTapped(sender: sender)
    }
    
    
    @IBAction func flipButtonAction(_ sender: UIButton) {
        self.delegate?.cameraFlipButtonDidTapped(sender: sender)
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
