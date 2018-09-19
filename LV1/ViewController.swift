//
//  UploadController.swift
//  AWS S3 TransferUtility
//
//  Created by Ameenah Burhan on 9/24/17.
//  Copyright © 2017 Ameenah Burhan. All rights reserved.
//

import UIKit
import AWSS3

class UploadController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
   
    let picker = UIImagePickerController()
    
    var selectedImage: UIImage!{
        didSet{
            saveButton.isEnabled = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
    }
   
    @IBAction func photoLibrary(_ sender: UIButton) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)

    }
    @IBAction func saveButton(_ sender: UIButton) {
        statusLabel.text = "Loading..."
        guard let image = imageView.image else {return}
        if let data = UIImagePNGRepresentation(image){
            DispatchQueue.main.async(execute: {
                let transferUtility = AWSS3TransferUtility.default()
                let S3BucketName = "lvvm"
                let expression = AWSS3TransferUtilityUploadExpression()
                
                transferUtility.uploadData(data, bucket: S3BucketName, key: "VM_Wall.png", contentType: "image/png", expression: expression) { (task, error) in
                    if let error = error{
                        print(error.localizedDescription)
                        return
                    }
                    self.statusLabel.text = "Success"
                }
            })
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = (info[UIImagePickerControllerOriginalImage] as? UIImage){
            selectedImage = image
            imageView.image = selectedImage
        }
        dismiss(animated:true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func sendImage(_ sender: Any) {
        performSegue(withIdentifier: "toBrowsePage", sender: nil)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toBrowsePage" {
            let dvc = segue.destination as! skuViewController
            dvc.newImage = imageView.image
        }
    }

}



/*import UIKit
import AWSS3
import AWSCognito
import Photos
import AWSCore



class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBAction func openCameraButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let camImagePicker = UIImagePickerController()
            camImagePicker.delegate = self
            camImagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            camImagePicker.allowsEditing = false
            self.present(camImagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func openPhotoLibraryButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    @IBOutlet weak var progressView: UIProgressView!
    
    //handles upload
    var uploadCompletionHandler: AWSS3TransferUtilityUploadCompletionHandlerBlock?
    var uploadFileURL: NSURL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //setting progress bar to 0
        self.progressView.progress = 0.0;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //begin upload from photo library
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        //first run if its coming from photo album
        if(picker.sourceType == UIImagePickerControllerSourceType.photoLibrary)
        {
           /*
            let tempImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            
            let image = UIImageJPEGRepresentation(tempImage!, 0.2)
            
            let path = try! FileManager.default.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
            let imageName = UUID().uuidString + ".jpg"
            
            let aPath = path.path
            
            let imagePath = (aPath as NSString).appendingPathComponent(imageName)
            do {
                let result = try image?.write(to: URL(fileURLWithPath: path, options: .atomic))
            } catch let error {
                print(error)
            }
 */
         
            //getting details of image
            let uploadFileURL = info[UIImagePickerControllerReferenceURL] as! NSURL
            
            let imageName = uploadFileURL.lastPathComponent
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as String
            
            // getting local path
            let localPath = (documentDirectory as NSString).appendingPathComponent(imageName!)
            
            
            //getting actual image
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            let data = UIImageJPEGRepresentation(image, 0.2)
            do {
                try data?.write(to: URL(fileURLWithPath: localPath), options:.atomic)

            } catch let error {
                print(error)
            }
           // data?.write(to: URL(fileURLWithPath: localPath), options:.atomic)
            
            let imageData = NSData(contentsOfFile: localPath)!
            let photoURL = NSURL(fileURLWithPath: localPath)
       
            // let imageWithData = UIImage(data: imageData)!
       
            
            //defining bucket and upload file name
            let S3BucketName: String = "BUCKET-NAME"
            let S3UploadKeyName: String = "FileName.jpg"
            
            
            
            
            let expression = AWSS3TransferUtilityUploadExpression()
            expression.uploadProgress = {(task: AWSS3TransferUtilityTask, bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) in
                dispatch_async(dispatch_get_main_queue(), {
                    let progress = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
                    self.progressView.progress = progress
                    // self.statusLabel.text = "Uploading..."
                    NSLog("Progress is: %f",progress)
                })
            }
            
            self.uploadCompletionHandler = { (task, error) -> Void in
                dispatch_async(dispatch_get_main_queue(), {
                    if ((error) != nil){
                        NSLog("Failed with error")
                        NSLog("Error: %@",error!);
                        //    self.statusLabel.text = "Failed"
                    }
                    else if(self.progressView.progress != 1.0) {
                        //    self.statusLabel.text = "Failed"
                        NSLog("Error: Failed - Likely due to invalid region / filename")
                    }
                    else{
                        //    self.statusLabel.text = "Success"
                        NSLog("Sucess")
                    }
                })
            }
            
            let transferUtility = AWSS3TransferUtility.default()
            
            transferUtility.uploadFile(photoURL as URL, key: S3UploadKeyName, contentType: "image/jpeg", bucket: S3BucketName).continueWith { (task) -> AnyObject! in
                if let error = task.error {
                    NSLog("Error: %@",error.localizedDescription);
                    //  self.statusLabel.text = "Failed"
                }
                if let exception = task.exception {
                    NSLog("Exception: %@",exception.description);
                    //   self.statusLabel.text = "Failed"
                }
                if let _ = task.result {
                    // self.statusLabel.text = "Generating Upload File"
                    NSLog("Upload Starting!")
                    // Do something with uploadTask.
                }
                
                return nil;
            }
            
            //end if photo library upload
            self.dismiss(animated: true, completion: nil);
            
        }
            
            
 
            //second check if its coming from camera
   /*     else if(picker.sourceType == UIImagePickerControllerSourceType.camera)
        {
            
            //  var imageToSave: UIImage = info(UIImagePickerControllerOriginalImage) as UIImage
            var imageToSave: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            //defining bucket and upload file name
            let S3BucketName: String = "BUCKET-NAME"
            //setting temp name for upload
            let S3UploadKeyName = "File-Namejpg"
            
            //settings temp location for image
            let imageName = NSURL.fileURL(withPath: NSTemporaryDirectory() + S3UploadKeyName).lastPathComponent
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as String
            
            // getting local path
            let localPath = (documentDirectory as NSString).appendingPathComponent(imageName)
            
            
            //getting actual image
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            let data = UIImagePNGRepresentation(image)
            data!.writeToFile(localPath, atomically: true)
            
            let imageData = NSData(contentsOfFile: localPath)!
            let photoURL = NSURL(fileURLWithPath: localPath)
            
            
            
            let expression = AWSS3TransferUtilityUploadExpression()
            expression.uploadProgress = {(task: AWSS3TransferUtilityTask, bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) in
                dispatch_async(dispatch_get_main_queue(), {
                    let progress = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
                    self.progressView.progress = progress
                    // self.statusLabel.text = "Uploading..."
                    NSLog("Progress is: %f",progress)
                })
            }
            
            self.uploadCompletionHandler = { (task, error) -> Void in
                dispatch_async(dispatch_get_main_queue(), {
                    if ((error) != nil){
                        NSLog("Failed with error")
                        NSLog("Error: %@",error!);
                        //    self.statusLabel.text = "Failed"
                    }
                    else if(self.progressView.progress != 1.0) {
                        //    self.statusLabel.text = "Failed"
                        NSLog("Error: Failed - Likely due to invalid region / filename")
                    }
                    else{
                        //    self.statusLabel.text = "Success"
                        NSLog("Sucess")
                    }
                })
            }
            
            let transferUtility = AWSS3TransferUtility.default()
            
            transferUtility.uploadFile(photoURL, bucket: S3BucketName, key: S3UploadKeyName, contentType: "image/jpeg", expression: expression, completionHander: uploadCompletionHandler).continueWithBlock { (task) -> AnyObject! in
                if let error = task.error {
                    NSLog("Error: %@",error.localizedDescription);
                    //  self.statusLabel.text = "Failed"
                }
                if let exception = task.exception {
                    NSLog("Exception: %@",exception.description);
                    //   self.statusLabel.text = "Failed"
                }
                if let _ = task.result {
                    // self.statusLabel.text = "Generating Upload File"
                    NSLog("Upload Starting!")
                    // Do something with uploadTask.
                }
                
                return nil;
            }
            
            //end if photo library upload
            self.dismiss(animated: true, completion: nil);
            
            
            
        }
                                                       */
        else{
            NSLog("NOOOO!")
        }
        
        
    }
    
}





/*
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var myImageView: UIImageView!
    let imagePicker = UIImagePickerController()
    @IBAction func uploadButtonTapped(_ sender: AnyObject) {
        
        //myImageUploadRequest()
        
    }
    
    @IBAction func selectPhotoButtonTapped(_ sender: AnyObject) {
        
        //let myPickerController = UIImagePickerController()
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            myImageView.contentMode = .scaleAspectFit
            myImageView.image = pickedImage
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        //myImageUploadRequest()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
  */

}

*/
