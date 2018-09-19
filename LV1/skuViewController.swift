//
//  skuViewController.swift
//  LV1
//
//  Created by Akshay Kirane on 4/9/18.
//  Copyright © 2018 Akshay Kirane. All rights reserved.
//

import UIKit

class skuViewController: UIViewController {
    
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    var newImage: UIImage!
    let wall1image = UIImage(named: "wall1.jpeg")
    let wall2image = UIImage(named: "wall2.jpeg")
    let wall3image = UIImage(named: "wall3.jpeg")
    let wall4image = UIImage(named: "wall4.jpeg")

    var imageArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainScrollView.frame = view.frame
        
       
        
        
        
        
     /*  if isEqualImages(image1: newImage, image2: wall1image!){
            imageArray = [UIImage(named: "wall61.png")!, UIImage(named: "w62.png")!, UIImage(named: "w63.png")!, UIImage(named: "w64.png")!, UIImage(named: "w65.png")!, UIImage(named: "w66.png")!, UIImage(named: "w67.png")!, UIImage(named: "w68.png")!]

       }else if isEqualImages(image1: newImage, image2: wall2image!){
            imageArray = [UIImage(named: "wall61.png")!, UIImage(named: "w62.png")!, UIImage(named: "w63.png")!, UIImage(named: "w64.png")!, UIImage(named: "w65.png")!, UIImage(named: "w66.png")!, UIImage(named: "w67.png")!, UIImage(named: "w68.png")!]
       }else if isEqualImages(image1: newImage, image2: wall3image!){
            imageArray = [UIImage(named: "wall61.png")!, UIImage(named: "w62.png")!, UIImage(named: "w63.png")!, UIImage(named: "w64.png")!, UIImage(named: "w65.png")!, UIImage(named: "w66.png")!, UIImage(named: "w67.png")!, UIImage(named: "w68.png")!]

       }else {
        
             imageArray = [UIImage(named: "wall61.png")!, UIImage(named: "w62.png")!, UIImage(named: "w63.png")!, UIImage(named: "w64.png")!, UIImage(named: "w65.png")!, UIImage(named: "w66.png")!, UIImage(named: "w67.png")!, UIImage(named: "w68.png")!]

        }
        
        
*/
        
    imageArray = [UIImage(named: "h1.jpg")!, UIImage(named: "h2.jpg")!, UIImage(named: "h3.jpg")!, UIImage(named: "h4.jpg")!, UIImage(named: "h5.jpg")!, UIImage(named: "h6.jpg")!, UIImage(named: "h7.jpg")!, UIImage(named: "h1.jpg")!, UIImage(named: "h8.jpg")!, UIImage(named: "h9.jpg")!, UIImage(named: "h10.jpg")!, UIImage(named: "h11.jpg")!, UIImage(named: "h12.jpg")!, UIImage(named: "h13.jpg")!, UIImage(named: "h14.jpg")!]
        
        for i in 0..<imageArray.count{
            
            let imageView = UIImageView()
            imageView.image = imageArray[i]
            imageView.contentMode = .scaleAspectFit
            let xPosition = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.mainScrollView.frame.width, height: self.mainScrollView.frame.height)
            mainScrollView.contentSize.width = mainScrollView.frame.width * CGFloat(i + 1)
            mainScrollView.addSubview(imageView)
            
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    func isEqualImages(image1: UIImage, image2: UIImage) -> Bool {
        let data1: Data? = UIImagePNGRepresentation(image1)
        let data2: Data? = UIImagePNGRepresentation(image2)
        return data1 == data2
    }
    
    
   /* func areEqualImages(img1: UIImage, img2: UIImage) -> Bool {
        
        guard let data1 = UIImagePNGRepresentation(img1) else { return false }
        guard let data2 = UIImagePNGRepresentation(img2) else { return false }
        
        return data1.isEqualToData(data2)
    } */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
