//
//  CustomView.swift
//  ViewsRotatoion
//
//  Created by student on 8/1/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit



class CustomView: UIView {
    
    var retriever:CustomViewProtocol?
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
 
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = generateColor()
        var tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapGesture)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func tapped(){
        print("tapped")
        self.retriever?.recieveTap()
    }
    
  
    func generateColor() -> UIColor{
        let red = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        let green = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        let blue = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        return UIColor(red:red,green:green,blue:blue,alpha: 1.0)
    }
    
}
