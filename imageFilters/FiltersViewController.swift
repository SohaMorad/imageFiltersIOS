//
//  FiltersViewController.swift
//  imageFilters
//
//  Created by Soha Mourad on 2019-05-30.
//  Copyright © 2019 Soha Mourad. All rights reserved.
//

import UIKit


class FiltersViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    
    
   let imagePicker = UIImagePickerController()
    
    @IBAction func loadImageButtonTapped(sender: UIButton) {
        
        
        
        //imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var btn_loadimg: UIButton!
    
    
    struct orgImg {
        static  var name = UIImage.init()
        
    }
    
    struct edgesFilter {
        
       
        static var apply = "1"
        
    }
    
    
    @IBOutlet weak var imgPlaceHolder: UIImageView!
    
    @IBOutlet weak var Slider: UISlider!
    
   
   
    @IBOutlet weak var label: UILabel!
    
   
    
    
    
    override func viewDidLoad() {
        
        
       
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        orgImg.name = imgPlaceHolder.image!
        

     
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func upload_img(_ sender: Any) {
        
        
       
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            
           // imgPlaceHolder.contentMode = .scaleAspectFit
            imgPlaceHolder.image = pickedImage
            
                orgImg.name = pickedImage
            dismiss(animated: true, completion: nil)
        }
    }
    
    /*
    
    
    private func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info:  [UIImagePickerController : AnyObject]) {
    
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as UIImage {
            
        
            imgPlaceHolder.contentMode = .scaleAspectFit
            imgPlaceHolder.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    */
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
   
    @IBAction func ApplyFilter(_ sender: Any) {
        
        edgesFilter.apply = label.text!
        applyFilter()
        
        
    }
    
   
    @IBAction func changeValue(_ sender: UISlider) {
        
        
        label.text = String(Int(sender.value))
    }
    
   
    
    
   // @IBAction func ApplyFilter(_ sender: Any) {
        
     //  edgesFilter.apply = Int(label.text)

       
   // }
    
    
    @IBAction func firstFilter(_ sender: Any) {
        
        
        
        let inputImage = orgImg.name
        
        let rawImg = CIImage(image: inputImage)
        let EffectNoirParams: [String : Any] = [kCIInputImageKey: rawImg  ]
        let PhotoEffectNoirFilter = CIFilter(name: "CIPhotoEffectNoir", parameters : EffectNoirParams)
        let context = CIContext(options: nil)
        
        if let output = PhotoEffectNoirFilter?.outputImage{
            if  let ciImg = context.createCGImage(output, from: output.extent){
                let finalResult = UIImage(cgImage: ciImg)
        imgPlaceHolder.image = finalResult
                
                
                
        
            }
        
    }
    }
    
    
    @IBAction func second_Filter(_ sender: Any) {
       
        let inputImage = orgImg.name
        
        let rawImg = CIImage(image: inputImage)
        let ColorInvertParams: [String : Any] = [kCIInputImageKey: rawImg ]
        let ColorInvertFilter = CIFilter(name: "CIColorInvert", parameters : ColorInvertParams)
        let context = CIContext(options: nil)
        
        if let output = ColorInvertFilter?.outputImage{
            if  let ciImg = context.createCGImage(output, from: output.extent){
                let finalResult = UIImage(cgImage: ciImg)
        
        imgPlaceHolder.image = finalResult
        
        
        
    }
        }
    }
    
    
    
    @IBAction func third_Filter(_ sender: Any) {
        
        applyFilter()
        //let currentValue = Int(sender.value)
       // Slider.maximumValue = 0.5
       // Slider.minimumValue = 1
        
      
    }
    
    
    @IBAction func Original(_ sender: Any) {
        
        
        
        
        
       imgPlaceHolder.image = orgImg.name
       
        
    }
    
    func applyFilter(){
        
        let inputImage = orgImg.name
        
        let rawImg = CIImage(image: inputImage)
        let EdgesParams: [String : Any] = [kCIInputImageKey: rawImg , kCIInputIntensityKey: Int(edgesFilter.apply)]
        let EdgesFilter = CIFilter(name: "CIEdges", parameters : EdgesParams)
        let context = CIContext(options: nil)
        
        if let output = EdgesFilter?.outputImage{
            if  let ciImg = context.createCGImage(output, from: output.extent){
                let finalResult = UIImage(cgImage: ciImg)
                
                imgPlaceHolder.image = finalResult
                
            }
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
