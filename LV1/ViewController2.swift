//
//  ViewController2.swift
//  LV1
//
//  Created by Akshay Kirane on 3/9/18.
//  Copyright © 2018 Akshay Kirane. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var pickerDataSource = ["LV 5th Avenue", "LV Bloomingdales", "LV Macy's", "LV Soho"];

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
      override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;

        // Do any additional setup after loading the view.
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
