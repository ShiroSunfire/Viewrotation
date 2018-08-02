//
//  ViewController.swift
//  ViewsRotatoion
//
//  Created by student on 8/1/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit

protocol  CustomViewDelegate {
    func recieveTap(ID:Int)
}

class ViewController: UIViewController, CustomViewDelegate {

  
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
        calculateMaxAmountOfViews()
    }
    
    func calculateMaxAmountOfViews(){
        let maxWidthAmount = (Double(screenWidth) - WIDTH) / 10.0
        let maxHeightAmount = (Double(screenHeight) - HEIGHT) / 10.0
        maxAmountOfViews = Int(maxWidthAmount < maxHeightAmount ? maxWidthAmount : maxHeightAmount)
    }
    
    @IBAction func proccesViewsAmountTextField(_ sender: UIButton) {
        cleanMainView()
        
        if let amountOfViews = Int(recievingAmountOfViewsTextField.text!){
            if amountOfViews > maxAmountOfViews!{
              callAlert()
            }else{
                 generateViewsToMainView(viewsAmount: amountOfViews, x: 0.0, y: 0.0, widht: WIDTH, height: HEIGHT, toView: mainView)
            }
        }else{
            callAlert()
        }
    }
    


    func callAlert()
    {
        var textField = UITextField()
        let alert = UIAlertController(title: "Incorrect amount", message: "Max amount is \(maxAmountOfViews!)", preferredStyle: .alert)
      
        let submitButton = UIAlertAction(title: "submit", style: .default) { (action) in
            if textField.text != nil && Int(textField.text!) != nil && Int(textField.text!)! <= self.maxAmountOfViews!{
                let viewsAmount = Int(textField.text!)
                self.generateViewsToMainView( viewsAmount:  viewsAmount!, x: 0.0, y: 0.0, widht: self.WIDTH, height: self.HEIGHT, toView: self.mainView)
            }else{
            self.callAlert()
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
                let temp = view.subviews[0] as! CustomView
                if view.superview == mainView{
                    temp.frame = CGRect(x: 0.0, y: 0.0, width: temp.frame.width, height: temp.frame.height)
                }
                view.superview?.insertSubview(temp, aboveSubview: view.superview!)
                
            }
            view.removeFromSuperview()
        }else{
            deleteViewById(view: view.subviews[0] as! CustomView, ID: ID)
        }
    }
    
    
    func generateViewsToMainView(viewsAmount: Int,x:Double,y:Double,widht:Double,height:Double,toView:UIView){
        if viewsAmount == 0 {
        } else if viewsAmount > 0{
   
            let currView = CustomView(frame: CGRect(x: x, y:y, width:widht, height: height))
            currView.setId(id: viewsAmount - 1)
            toView.insertSubview(currView, aboveSubview: toView)
            currView.retriever = self
            generateViewsToMainView( viewsAmount: viewsAmount - 1, x: OFFSET , y: OFFSET, widht: widht, height: height, toView:currView)
        }
    }
    
    func cleanMainView(){
        if !mainView.subviews.isEmpty{
            mainView.subviews[0].removeFromSuperview()
        }
    }
    
    
}

