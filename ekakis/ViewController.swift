//
//  ViewController.swift
//  ekakis
//
//  Created by Morikawa Gento on 2017/09/03.
//  Copyright © 2017年 gentom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var canvas: UIImageView!
    var lastPoint = CGPoint.zero
    var swiped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first {
            lastPoint = touch.location(in: self.view)
        }
    }
    
    func drawLines(fromPoint:CGPoint,toPoint:CGPoint){
        UIGraphicsBeginImageContext(self.view.frame.size)
        canvas.image?.draw(in: CGRect(x:0,y:0,width:self.view.frame.width,height:self.view.frame.height))
        let context = UIGraphicsGetCurrentContext()
        context?.move(to: CGPoint(x:fromPoint.x,y:fromPoint.y))
        context?.addLine(to: CGPoint(x:toPoint.x,y:toPoint.y))
        context?.setBlendMode(CGBlendMode.normal)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(5)
        context?.setStrokeColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor)
        context?.strokePath()
        canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        if let touch = touches.first {
            let currentPoint = touch.location(in: self.view)
            drawLines(fromPoint: lastPoint, toPoint: currentPoint)
            
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped{
            drawLines(fromPoint: lastPoint, toPoint: lastPoint)
        }
    }
}
