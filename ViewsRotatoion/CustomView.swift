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
    var ID:Int?
    var tapGesture:UITapGestureRecognizer?
    
    
    override func draw(_ rect: CGRect) {
 
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = generateColor()
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapped))
        tapGesture?.numberOfTapsRequired = 1
        tapGesture?.numberOfTouchesRequired = 1
        tapGesture?.delegate = self
        self.addGestureRecognizer(tapGesture!)
        self.isUserInteractionEnabled = true
        
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
	
        if self.point(inside: point, with: event) {
            return super.hitTest(point, with: event)
        }
        guard isUserInteractionEnabled, !isHidden, alpha > 0 else {
            return nil
        }
        
        for subview in subviews.reversed() {
            let convertedPoint = subview.convert(point, from: self)
            if let hitView = subview.hitTest(convertedPoint, with: event) {
                return hitView
            }
        }
        return nil
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setId(id:Int){
        self.ID = id
    }
    
    @objc func tapped(sender: UITapGestureRecognizer){

        print("GESTURA VIZVANA")
        if let id = self.ID{
            self.retriever?.recieveTap(ID:id)
        }
    }
    
    func convertFrameToReal(view:UIView,frame:CGRect) ->CGRect{
        if view.superview == nil{
            return frame
        }else{
            return convertFrameToReal(view: view.superview!, frame: frame + view.convert(view.frame, to: view.superview))
        }
        
    }
    
    func generateColor() -> UIColor{
        let red = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        let green = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        let blue = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        return UIColor(red:red,green:green,blue:blue,alpha: 1.0)
    }
    
}
extension CGRect{
    static func + (lRect:CGRect,rRect:CGRect) -> CGRect{
        let x = lRect.minX + rRect.minX
        let y = lRect.minY + rRect.minY
//        let height = lRect.height + rRect.height
//        let width = lRect.width + rRect.width
        return CGRect(x: x, y: y, width: lRect.width, height: lRect.height)
    }
}
extension CustomView: UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UIPress) -> Bool {
        return !self.isDescendant(of: self.superview!)
        
    }
    
}



