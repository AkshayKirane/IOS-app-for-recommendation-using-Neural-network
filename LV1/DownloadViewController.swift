//
//  DownloadViewController.swift
//  LV1
//
//  Created by Akshay Kirane on 4/5/18.
//  Copyright © 2018 Akshay Kirane. All rights reserved.
//

import UIKit
import AWSS3
class DownloadViewController: UIViewController {

    let S3BucketName = "lvvm"
    let S3DownloadKeyName = "neverfull.png"
    
 //   @IBOutlet weak var imageView: UIImageView!
    
 //   @IBOutlet weak var progressView: UIProgressView!
    
   // @IBOutlet weak var statusLabel: UILabel!
    
   // var completionHandler: AWSS3TransferUtilityDownloadCompletionHandlerBlock?
    
   // let transferUtility = AWSS3TransferUtility.default()
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  self.progressView.progress = 0.0;
       // self.statusLabel.text = "Ready"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  /*  @IBAction func start(_ sender: UIButton) {
        self.imageView.image = nil;
        
        let expression = AWSS3TransferUtilityDownloadExpression()
        expression.progressBlock = {(task, progress) in
            DispatchQueue.main.async(execute: {
                self.progressView.progress = Float(progress.fractionCompleted)
                self.statusLabel.text = "Downloading..."
            })
        }
        
        self.completionHandler = { (task, location, data, error) -> Void in
            DispatchQueue.main.async(execute: {
                if let error = error {
                    NSLog("Failed with error: \(error)")
                    self.statusLabel.text = "Failed"
                }
                else if(self.progressView.progress != 1.0) {
                    self.statusLabel.text = "Failed"
                    NSLog("Error: Failed - Likely due to invalid region / filename")
                }
                else{
                    self.statusLabel.text = "Success"
                    self.imageView.image = UIImage(data: data!)
                }
            })
        }
        
        transferUtility.downloadData(
            fromBucket: S3BucketName,
            key: S3DownloadKeyName,
            expression: expression,
            completionHandler: completionHandler).continueWith { (task) -> AnyObject? in
                if let error = task.error {
                    NSLog("Error: %@",error.localizedDescription);
                    self.statusLabel.text = "Failed"
                }
                
                if let _ = task.result {
                    self.statusLabel.text = "Starting Download"
                    NSLog("Download Starting!")
                    // Do something with uploadTask.
                }
                return nil;
        }
    }*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
