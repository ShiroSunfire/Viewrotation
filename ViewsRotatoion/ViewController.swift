//
//  ViewController.swift
//  ViewsRotatoion
//
//  Created by student on 8/1/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit


protocol  CustomViewDelegate {
    func viewTapped(sender:UITapGestureRecognizer)
}

class ViewController: UIViewController{

    let OFFSET = 1.0
    let WIDTH = 80.0
    let HEIGHT = 120.0
    
    @IBOutlet weak var recievingAmountOfViewsTextField: UITextField!
    
    @IBOutlet weak var mainView: UIView!
    
 
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
                 generateViewsToMainView(viewsAmount: amountOfViews, toView: mainView)
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
                self.generateViewsToMainView( viewsAmount:  viewsAmount!, toView: self.mainView)
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
    
  
    
    
    func deleteView(view:UIView){
        
            if !view.subviews.isEmpty{
                let temp = view.subviews[0] as! CustomView
                let customView = view as! CustomView
                temp.viewConstrains = customView.viewConstrains
                NSLayoutConstraint.activate(temp.viewConstrains)
                view.superview?.insertSubview(temp, aboveSubview: view.superview!)
                
            }
            updateViewConstraints()
            view.removeFromSuperview()
    }
    
    
    func generateViewsToMainView(viewsAmount: Int, toView:UIView){
        struct Handler{
            static var number = 0
        }
        
        
        if viewsAmount == Handler.number {
            Handler.number = 0
        } else if viewsAmount > Handler.number{
   
            let currView = CustomView()
            toView.insertSubview(currView, aboveSubview: toView)
            currView.setConstrains(to: mainView, numberOfView: Handler.number)
            currView.delegate = self
            Handler.number += 1
            generateViewsToMainView( viewsAmount: viewsAmount, toView:currView)
        }
    }
    
    func cleanMainView(){
        if !mainView.subviews.isEmpty{
            mainView.subviews[0].removeFromSuperview()
        }
    }
    
    
}

extension ViewController: CustomViewDelegate{
   
    func viewTapped(sender:UITapGestureRecognizer){
        deleteView(view: sender.view!)
    }
    
}

