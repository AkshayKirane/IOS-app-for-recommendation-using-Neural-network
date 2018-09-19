//
//  pickerViewController.swift
//  LV1
//
//  Created by Akshay Kirane on 4/5/18.
//  Copyright © 2018 Akshay Kirane. All rights reserved.
//

import UIKit
import AWSS3



class pickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate {

    
    @IBOutlet weak var send: UIButton!
    @IBOutlet weak var statusLabel1: UILabel!
    @IBOutlet weak var storeField: UITextField!
    
    let stores = ["UBH", "UFA", "UMX", "M04","UEZ","URD","M01","UBS","UBT","UCH","UCI","UCU","UFV","UHG", "UJM", "ULS", "UMD", "UMH",
                  "UPP", "USO", "USS", "UVH", "UWM", "UMT", "UTY", "UAC", "ULY",
                  "UMP", "UIG", "UTP", "UMY", "UGD", "UBX", "UVF", "UAG", "UAS",
                  "UCR", "UNE", "UNL", "UNR", "UOC", "UOG", "USQ", "USW", "UBV",
                  "UDO", "UNC", "USA", "UCE", "UCS", "UDX", "UPS", "UJF", "UAR",
                  "UOR", "UPM", "UPN", "UGS", "UKP", "ULZ", "USM", "URJ", "URK",
                  "USH", "UTM", "UBL", "USL", "UHS", "UMR", "UTF", "UWC", "UCK",
                  "UTO", "UIN", "UPF", "UHX", "UNF", "UHY", "URZ", "UTA", "USC",
                  "UCP", "UVG", "UBN", "UCC", "UPG", "UPH", "UPR", "UVC", "UWB",
                  "UWD", "UBR", "UCA", "UCL", "UWY", "UNK", "UPZ", "UVM", "URR",
                  "UNV", "USY", "UBG", "UCF", "UBM", "UHC", "UNY", "ULB", "UNZ",
                  "UMN", "UWA", "UOH", "UNI", "UAF", "UTH", "UPV", "UMA", "UPK",
                  "URS", "UHE", "UGF", "UPD", "USB", "UND", "UBU", "USX", "UNN",
                  "ULA", "UHB", "UWE", "UDC", "UDG", "UCN", "USU", "ULG", "UBE",
                  "U10", "UTX", "UNT", "UWW", "UBP", "UMV", "UWP", "M11", "UO6",
                  "UNH", "UPB", "UVT", "UKF", "UBA", "M05", "M10", "UNJ", "UNX",
                  "USN", "UO2", "USJ", "UMO"]
    
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        storeField.inputView = pickerView
        storeField.textAlignment = .center
        storeField.placeholder = "Select your store"
        
        // Do any additional setup after loading the view.
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return stores.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stores[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        storeField.text = stores[row]
        storeField.resignFirstResponder()
    }
    
    @IBAction func send(_ sender: UIButton) {
        statusLabel1.text = "Loading..."
        let data1 = storeField.text
        if let newData = data1?.data(using: String.Encoding.utf8){
            DispatchQueue.main.async(execute: {
                let transferUtility = AWSS3TransferUtility.default()
                let S3BucketName = "lvvm"
                let expression = AWSS3TransferUtilityUploadExpression()
                
                transferUtility.uploadData(newData, bucket: S3BucketName, key: "store.txt", contentType: "text/plain", expression: expression) { (task, error) in
                    if let error = error{
                        print(error.localizedDescription)
                        return
                    }
                    self.statusLabel1.text = "Success"
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
