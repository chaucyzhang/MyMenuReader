//
//  ViewController.swift
//  MyMenuReader
//
//  Created by xi zhang on 1/10/18.
//  Copyright © 2018 xi zhang. All rights reserved.
//

import UIKit
import TesseractOCR
import Alamofire
import SwiftyJSON

class MainViewController: UIViewController, G8TesseractDelegate, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CameraViewControllerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    var image:UIImage?
    var tesseract:G8Tesseract?
    var imagePicker:UIImagePickerController?
    var gallery:GalleryViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.image = self.imageView.image
        self.setupOCR()
        
        //self.setupCamera()
        //
        //        self.present(self.imagePicker!, animated: true) {
        //
        //        }
//        self.startRecognizing()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupOCR() {
        let tesseract = G8Tesseract.init(language: "eng");
        tesseract?.delegate = self
        self.tesseract = tesseract
        self.scrollView.delegate = self
    }
    
    func setupCamera(){
        let imagePicker = UIImagePickerController.init()
        imagePicker.sourceType = .camera
        imagePicker.showsCameraControls = true
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.isNavigationBarHidden = true
        imagePicker.isToolbarHidden = true
        imagePicker.edgesForExtendedLayout = .all;
        imagePicker.extendedLayoutIncludesOpaqueBars = true;
        imagePicker.cameraViewTransform = self.getFullScreenCamTransform()
        
        let overlayVC = CameraViewController()
        imagePicker.cameraOverlayView?.addSubview(overlayVC.view)
        self.imagePicker = imagePicker
    }
    
    func getFullScreenCamTransform() ->CGAffineTransform{
        let screenSize = UIScreen.main.bounds.size;
        let cameraAspectRatio = 4.0 / 3.0;
        let imageHeight = floorf(Float(Double(screenSize.width) * cameraAspectRatio));
        let scale = screenSize.height / CGFloat(imageHeight);
        let trans = (Float(screenSize.height) - imageHeight)/2;
        let translate = CGAffineTransform(translationX: 0.0, y: CGFloat(trans));
        let final = translate.scaledBy(x: scale, y: scale);
        return final;
    }
    
    func searchPhoto(text:String?){
        guard let text = text else{
            return
        }
        let q = text.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.alphanumerics)!
        let fields = "items(pagemap/cse_image)"
        let cx = "004765008655428480067%3Avu_tztcep10"
        let key = "AIzaSyDrz6Ut6BjgVwG-EP8aA561L3_sq2xOpnA"
        let url = "https://www.googleapis.com/customsearch/v1?q=\(q)&fields=\(fields)&cx=\(cx)&key=\(key)";
        Alamofire.request(url).responseJSON{ response in
            switch response.result{
            case .success:
                guard let resultValue = response.result.value else {
                    NSLog("Result value in response is nil")
                    return
                }
                let responseJSON = JSON(resultValue)
                self.processImageData(data:responseJSON)
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    func processImageData(data:JSON){
        var photos = [String]()
        for (_,items):(String, JSON) in data {
            for (_,item):(String, JSON) in items{
                if let src = item["pagemap"]["cse_image"][0]["src"].string{
                    photos.append(src)
                }
            }
        }
        
        self.gallery = GalleryViewController()
        self.gallery?.photos = photos
        
        self.present(self.gallery!, animated: true) {
            
        }
    }
    
    func startRecognizing() {
        self.tesseract?.image = self.image?.g8_blackAndWhite()
        self.tesseract?.recognize()
        print(tesseract?.recognizedText! as Any)
        
        if let text = tesseract?.recognizedText {
            self.searchPhoto(text:text)
        }
        
    }
    
    
    //ocr delegate methods
    func progressImageRecognition(for tesseract: G8Tesseract!) {
        print("recognition progress: \(tesseract.progress)")
    }
    
    func shouldCancelImageRecognitionForTesseract(tesseract: G8Tesseract!) -> Bool {
        return false // return true if you need to interrupt tesseract before it finishes
    }
    
    //scroll view delegate methods
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
    }
    
    //camera vc delegate methods
    func cameraFlipButtonDidTapped(sender: UIButton) {
        if self.imagePicker?.cameraDevice == UIImagePickerControllerCameraDevice.front
        {
            self.imagePicker?.cameraDevice = UIImagePickerControllerCameraDevice.rear
        }
        else {
            self.imagePicker?.cameraDevice = UIImagePickerControllerCameraDevice.front
        }
        self.imagePicker?.cameraViewTransform = (self.imagePicker?.cameraViewTransform.scaledBy(x: -1, y: 1))!
    }
    
    func cameraCancelButtonDidTapped(sender: UIButton) {
        self.imagePicker?.dismiss(animated: true, completion: {
            
        })
    }
    
    func cameraFromGalleryButtonDidTapped(sender: UIButton) {
        
    }
    
    func cameraCaptureButtonDidTapped(sender: UIButton) {
        self.imagePicker?.takePicture()
    }
    
}

