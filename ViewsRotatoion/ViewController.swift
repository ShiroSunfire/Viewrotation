//
//  ViewController.swift
//  ViewsRotatoion
//
//  Created by student on 8/1/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit

protocol  CustomViewProtocol {
    func recieveTap(ID:Int)
}

class ViewController: UIViewController, CustomViewProtocol {

  
    @IBOutlet weak var recievingAmountOfViewsTextField: UITextField!
    
    @IBOutlet weak var mainView: UIView!
    let OFFSET = 10.0
    let WIDTH = 80.0
    let HEIGHT = 120.0
    var maxAmountOfViews:Int?
    
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let maxWidthAmount = (Double(screenWidth) - WIDTH) / 10.0
        let maxHeightAmount = (Double(screenHeight) - HEIGHT) / 10.0
        maxAmountOfViews = Int(maxWidthAmount < maxHeightAmount ? maxWidthAmount : maxHeightAmount)
        
    }
    
    @IBAction func proccesViewsAmountTextField(_ sender: UIButton) {
        cleanMainView()
        
        if let count = Int(recievingAmountOfViewsTextField.text!){
            if count > maxAmountOfViews!{
              callAlert()
            }else{
                 generateViewsToMainView(count: count, x: 0.0, y: 0.0, widht: WIDTH, height: HEIGHT, lastView: mainView)
            }
        }
        mainView.layoutIfNeeded()
    }
    

    func callAlert()
    {
        var textField = UITextField()
        let alert = UIAlertController(title: "Incorrect amount", message: "", preferredStyle: .alert)
      
        let submitButton = UIAlertAction(title: "submit", style: .default) { (action) in
            if textField.text != nil && Int(textField.text!) != nil && Int(textField.text!)! <= self.maxAmountOfViews!{
                let count = Int(textField.text!)
                self.generateViewsToMainView(count: count!, x: 0.0, y: 0.0, widht: self.WIDTH, height: self.HEIGHT, lastView: self.mainView)
            }
        }
        alert.addTextField { (alertTextField) in
            textField = alertTextField
        }
        alert.addAction(submitButton)
        self.recievingAmountOfViewsTextField.text = ""
        present(alert,animated: true,completion:  nil)
        
    }
    
    func recieveTap(ID:Int) {
        deleteViewById(view: mainView.subviews[0] as! CustomView, ID: ID)
    }
    
    
    func deleteViewById(view:CustomView,ID:Int){
        if view.ID! == ID{
            if !view.subviews.isEmpty{
                if view.superview != mainView{
                    let temp = view.subviews[0] as! CustomView
                    view.superview?.insertSubview(temp, aboveSubview: view.superview!)
                }
            }
            view.removeFromSuperview()
        }else{
            deleteViewById(view: view.subviews[0] as! CustomView, ID: ID)
        }
    }
    
    
    func generateViewsToMainView(count: Int,x:Double,y:Double,widht:Double,height:Double,lastView:UIView){
        var counter: Int = count
        if counter == 0 {
        } else if counter > 0{
            counter -= 1
            let currView = CustomView(frame: CGRect(x: x, y:y, width:widht, height: height))
            currView.setId(id: count)
            lastView.insertSubview(currView, aboveSubview: lastView)
            currView.retriever = self
            generateViewsToMainView(count: counter, x: OFFSET , y: OFFSET, widht: widht, height: height, lastView:currView)
        }
    }
    
    func cleanMainView(){
        if !mainView.subviews.isEmpty{
            mainView.subviews[0].removeFromSuperview()
        }
    }
    
    
}

