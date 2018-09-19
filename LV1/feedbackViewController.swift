//
//  feedbackViewController.swift
//  LV1
//
//  Created by Akshay Kirane on 4/6/18.
//  Copyright © 2018 Akshay Kirane. All rights reserved.
//

import UIKit
import AWSS3
class feedbackViewController: UIViewController {

    
    
    @IBOutlet weak var send: UIButton!
    @IBOutlet weak var statusLabel2: UILabel!
    
    @IBOutlet weak var cosmosViewFull: CosmosView!
    
    @IBOutlet weak var cosmosViewFull2: CosmosView!
    
    @IBOutlet weak var ratingLabel2: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    private let startRating:Float = 1.0
    private let startRating2:Float = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cosmosViewFull.didTouchCosmos = didTouchCosmos
        cosmosViewFull.didFinishTouchingCosmos = didFinishTouchingCosmos
        cosmosViewFull2.didTouchCosmos = didTouchCosmos
        cosmosViewFull2.didFinishTouchingCosmos = didFinishTouchingCosmos

        
        updateRating()
        updateRating2()

        // Do any additional setup after loading the view.
    }

    private func updateRating() {
        let value = startRating
        cosmosViewFull.rating = Double(value)
        self.ratingLabel.text = feedbackViewController.formatValue(Double(value))
        
    }
    private func updateRating2() {
        let value2 = startRating2
        cosmosViewFull2.rating = Double(value2)
        self.ratingLabel2.text = feedbackViewController.formatValue(Double(value2))
        
    }

    private class func formatValue(_ value: Double) -> String {
        return String(format: "%.2f", value)
    }
    
    private func didTouchCosmos(_ rating: Double) {
        ratingLabel.text = feedbackViewController.formatValue(rating)
        ratingLabel2.text = feedbackViewController.formatValue(rating)
    }
    
    private func didFinishTouchingCosmos(_ rating: Double) {
        self.ratingLabel.text = feedbackViewController.formatValue(rating)
        self.ratingLabel2.text = feedbackViewController.formatValue(rating)

    }
    

    
    @IBAction func send(_ sender: UIButton) {
        statusLabel2.text = "Loading..."
        let data1 = ratingLabel.text
        if let newData = data1?.data(using: String.Encoding.utf8){
            DispatchQueue.main.async(execute: {
                let transferUtility = AWSS3TransferUtility.default()
                let S3BucketName = "lvvm"
                let expression = AWSS3TransferUtilityUploadExpression()
                
                transferUtility.uploadData(newData, bucket: S3BucketName, key: "feedback.txt", contentType: "text/plain", expression: expression) { (task, error) in
                    if let error = error{
                        print(error.localizedDescription)
                        return
                    }
                    self.statusLabel2.text = "Your feedback has been recorded. Thank you!"
                }
            })
            
        }
        
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
