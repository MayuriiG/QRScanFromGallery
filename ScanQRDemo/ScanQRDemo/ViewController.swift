//
//  ViewController.swift
//  ScanQRDemo
//
//  Created by Mayuraa on 02/03/24.
//ONLY Tested FOR SIMULAtor

import UIKit


class ViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    //https://www.codingexplorer.com/choosing-images-with-uiimagepickercontroller-in-swift/
    @IBOutlet weak var imgVieww: UIImageView!
    let imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    
    @IBAction func loadImageButtonTapped(_ sender: UIButton) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
        //From Action Sheet Camera & Gallery  || Add info.plist  ||
//            let ac = UIAlertController(title: "Select Image", message: nil, preferredStyle: .actionSheet)
//            let cameraBtn = UIAlertAction(title: "Camera", style: .default) { _ in
//                self.showImagePicker(source: .camera)
//            }
//
//            let library = UIAlertAction(title: "Library", style: .default) { _ in
//                self.showImagePicker(source: .photoLibrary)
//            }
//            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
//            ac.addAction(cameraBtn)
//            ac.addAction(library)
//            ac.addAction(cancel)
//            present(ac, animated: true)
   //     }


    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
               imgVieww.contentMode = .scaleAspectFit
               // Detect QR code in the picked image
//
//               if let detectedFeatures = detectQRCode(pickedImage) {
//                   // QR code detected, do something with the detected features
//                   imgVieww.image = pickedImage
//               } else {
//                   print("No QR code detected in the selected image.")
//               }
            
            detectQRCode(from: pickedImage) { qrCodeContent in
                if let content = qrCodeContent {
                    print("QR Code content: \(content)")
                    imgVieww.image = pickedImage
                } else {
                    print("No QR code detected or invalid image")
                    let imageName = "img.jpeg"
                    imgVieww.image =  UIImage(named: "img.jpeg")
            } }
         }
         dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
          dismiss(animated: true, completion: nil)
    }
    
    
    
    func showImagePicker(source:UIImagePickerController.SourceType){
        guard   UIImagePickerController.isSourceTypeAvailable(source)else{  print("Not available ")
            return    }
        
        let imgePickerController  = UIImagePickerController()
        imgePickerController.delegate = self
        imgePickerController.sourceType = source
        imgePickerController.allowsEditing = false
        self.present(imgePickerController, animated: true)
        
    }
    
    
    
    func detectQRCode(from image: UIImage, completion: (String?) -> Void) {
        guard let ciImage = CIImage(image: image) else {
            completion(nil) // Invalid input image
            return
        }

        var options: [String: Any] = [:]
        let context = CIContext()
        options = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let qrDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: options)

        let orientation: NSNumber = NSNumber(value: image.imageOrientation.rawValue)
        options = [CIDetectorImageOrientation: orientation]
        guard let featuresDetect = qrDetector?.features(in: ciImage, options: options) as? [CIQRCodeFeature] else {
            completion(nil) // No QR code detected or features are not of type CIQRCodeFeature
            return
        }

        var qrCodeContent = ""
        for i in featuresDetect {
            if let messageString = i.messageString {
                qrCodeContent.append(messageString)
                qrCodeContent.append("\n")
                print("Content:>>>>>\(qrCodeContent)")
            }
        }

        completion(qrCodeContent.isEmpty ? nil : qrCodeContent)
    }

    
//    func detectQRCode(_ image: UIImage?) -> String? {
//        guard let image = image, let ciImage = CIImage(image: image) else {
//            return nil // Invalid input image
//        }
//
//        var options: [String: Any] = [:]
//        let context = CIContext()
//        options = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
//        let qrDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: options)
//
//
//        let orientation: NSNumber = NSNumber(value: image.imageOrientation.rawValue)
//        options = [CIDetectorImageOrientation: orientation]
//        guard let features = qrDetector?.features(in: ciImage, options: options) as? [CIQRCodeFeature] else {
//            return nil
//        }
//
//        var qrCodeContent = ""
//        for feature in features {
//            if let messageString = feature.messageString {
//                qrCodeContent.append(messageString)
//                qrCodeContent.append("\n")
//                print("Content:>>>>>\(qrCodeContent)")
//            }
//        }
//
//        return qrCodeContent.isEmpty ? nil : qrCodeContent
//
//    }

    
    
//    func detectQRCode(_ image: UIImage?) -> (content: String, format: String)? {
//        guard let image = image, let ciImage = CIImage(image: image) else {
//            return nil // Invalid input image
//        }
//
//        var options: [String: Any] = [:]
//        let context = CIContext()
//        options = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
//        let qrDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: options)
//
//        let orientation: NSNumber = NSNumber(value: image.imageOrientation.rawValue)
//        options = [CIDetectorImageOrientation: orientation]
//        guard let features = qrDetector?.features(in: ciImage, options: options) as? [CIQRCodeFeature] else {
//            return nil
//        }
//
//        var qrCodeContent = ""
//        for feature in features {
//            if let messageString = feature.messageString {
//                qrCodeContent.append(messageString)
//                qrCodeContent.append("\n")
//                print("Content:>>>>>\(qrCodeContent)")
//            }
//        }
//
//        let barcodeFormat = "QRCode" // Since you're specifically detecting QR codes
//        return qrCodeContent.isEmpty ? nil : (qrCodeContent, barcodeFormat)
//    }

       }


//Content:>>>>>0002010102110216408115000622288626350011fonepay.com071622225100062228855204565153035245802NP5922ABUKHAIRENI ALL STORES6015Anbukhaireni MC62100706635175630423fb

//01021129270023NCHL000004010401OZBFEMF52047299530352454010560105802NP5912RITESH NABIL6009Kathmandu6244010100306Store10709Terminal10812Bill payment64060002en63043E9E

