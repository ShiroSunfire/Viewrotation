//
//  CustomView.swift
//  ViewsRotatoion
//
//  Created by student on 8/1/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit



class CustomView: UIView {
    var delegate:CustomViewDelegate?
    var ID:Int?
    var viewConstrains = [NSLayoutConstraint]()
    let OFFSET = 1.0
    let WIDTH = 80.0
    let HEIGHT = 120.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = generateColor()
       addTapGesture()
        self.isUserInteractionEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapGesture)
    }
    
    
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
	
        if self.point(inside: point, with: event) {
            return super.hitTest(point, with: event)
        }
        
        if !subviews.isEmpty{
            let convertedPoint = subviews[0].convert(point, from: self)
            if let hitView = subviews[0].hitTest(convertedPoint, with: event) {
                return hitView
            }
        }
        
        return nil
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @objc func viewTapped(sender: UITapGestureRecognizer){
        self.delegate?.viewTapped(sender: sender)
    }
    
    
    func generateColor() -> UIColor{
        let red = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        let green = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        let blue = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        return UIColor(red:red,green:green,blue:blue,alpha: 1.0)
    }
    
    func getMainView() -> UIView{
        if self.superview! as? CustomView != nil{
            let father = self.superview! as? CustomView
            return (father?.getMainView())!
        }else{
            return self.superview!
        }
    }
    
    func setConstrains(to view:UIView,numberOfView:Int){
        viewConstrains.removeAll()
        
        let widthConstraint = self.widthAnchor.constraint(equalToConstant: CGFloat(WIDTH))
        let heightConstraint = self.heightAnchor.constraint(equalToConstant: CGFloat(HEIGHT))
        let leftConstraint = self.leftAnchor.constraintEqualToSystemSpacingAfter(view.leftAnchor, multiplier: CGFloat(OFFSET * Double(numberOfView)))
        let topConstraint = self.topAnchor.constraintEqualToSystemSpacingBelow(view.topAnchor, multiplier: CGFloat(OFFSET * Double(numberOfView)))
        
        viewConstrains = [widthConstraint,heightConstraint,leftConstraint,topConstraint]
        
        NSLayoutConstraint.activate(viewConstrains)
        
    }
    
}


