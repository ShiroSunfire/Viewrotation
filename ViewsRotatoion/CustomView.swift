//
//  CustomView.swift
//  ViewsRotatoion
//
//  Created by student on 8/1/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit


class CustomView: UIView {
    var retriever:CustomViewDelegate?
    var ID:Int?
    var tapGesture:UITapGestureRecognizer?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = generateColor()
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped))
        initOneTapViewGesture(gesture: tapGesture)
        self.isUserInteractionEnabled = true
        
    }

    
    func initOneTapViewGesture(gesture:UITapGestureRecognizer?){
        gesture?.numberOfTapsRequired = 1
        gesture?.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapGesture!)
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
        print("tap is gone")
        return nil
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setId(id:Int){
        self.ID = id
    }
    
    @objc func viewTapped(sender: UITapGestureRecognizer){

        print("GESTURA VIZVANA")
        if let id = self.ID{
            self.retriever?.recieveTap(ID:id)
        }
    }
    
    
    func generateColor() -> UIColor{
        let red = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        let green = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        let blue = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        return UIColor(red:red,green:green,blue:blue,alpha: 1.0)
    }
    
}


