//
//  ViewController.swift
//  ViewsRotatoion
//
//  Created by student on 8/1/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit

protocol  CustomViewProtocol {
    func recieveTap()
}

class ViewController: UIViewController, CustomViewProtocol {

  
    @IBOutlet weak var recievingAmountOfViewsTextField: UITextField!
    
    @IBOutlet weak var mainView: UIView!
    let OFFSET = 10.0
    let WIDTH = 80.0
    let HEIGHT = 120.0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func proccesViewsAmountTextField(_ sender: UIButton) {
        cleanMainView()
        if let count = Int(recievingAmountOfViewsTextField.text!){
            generateViewsToMainView(count: count, x: 0.0, y: 0.0, widht: WIDTH, height: HEIGHT, lastView: mainView)
        }
        mainView.layoutIfNeeded()
    }
    
    func recieveTap() {
        
    }
    
    
    func generateViewsToMainView(count: Int,x:Double,y:Double,widht:Double,height:Double,lastView:UIView){
        var counter: Int = count
        if counter == 0 {
        } else if counter > 0{
            counter -= 1
            let currView = CustomView(frame: CGRect(x: x, y:y, width:widht, height: height))
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

