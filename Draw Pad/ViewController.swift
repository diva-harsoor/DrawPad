//
//  ViewController.swift
//  DrawingPad
//
//  Created by Diva Harsoor on 7/24/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var storedImageView = UIImageView()
    var currentImageView = UIImageView()
    
    var colorButton = UIButton(), eraserButton = UIButton(), opacityButton = UIButton(), widthButton = UIButton(), arrowButton = UIButton()
    var buttons : [UIButton]!
    var imageNames : [String]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttons = [colorButton, eraserButton, opacityButton, widthButton, arrowButton]
        imageNames = ["colorImage", "eraserImage", "opacityImage", "widthImage", "arrowImage"]
        
        storedImageView = UIImageView(frame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 100))
        self.view.addSubview(storedImageView)
        currentImageView = UIImageView(frame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 100))
        self.view.addSubview(currentImageView)
        
        for i in 0..<buttons.count {
            var colorImage = UIImage(named: imageNames[i]) as UIImage?
            colorImage = resize(colorImage!, newWidth: 60)
            buttons[i] = UIButton(type: UIButtonType.Custom) as UIButton
            buttons[i].frame = CGRectMake(CGFloat(i) * 60, view.frame.size.height - 60, 60, 60)
            buttons[4].frame = CGRectMake(view.frame.size.width - 60, view.frame.size.height - 60, 60, 60)
            buttons[i].setImage(colorImage, forState: .Normal)
            colorButton.addTarget(self, action: #selector(self.onTappedColorButton), forControlEvents:.TouchUpInside)
            eraserButton.addTarget(self, action: #selector(self.onTappedEraserButton), forControlEvents:.TouchUpInside)
            opacityButton.addTarget(self, action: #selector(self.onTappedOpacityButton), forControlEvents:.TouchUpInside)
            widthButton.addTarget(self, action: #selector(self.onTappedWidthButton), forControlEvents:.TouchUpInside)
            arrowButton.addTarget(self, action: #selector(self.onTappedArrowButton), forControlEvents:.TouchUpInside)
            self.view.addSubview(buttons[i])
        }
        
    }
    
    func resize(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    var mostRecentPoint = CGPoint.zero
    var opacity: CGFloat = 1.0
    var singlePoint = true
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        singlePoint = true
        if let touch = touches.first {
            mostRecentPoint = touch.locationInView(self.view)
        }
    }
    
    func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        UIGraphicsBeginImageContext(currentImageView.frame.size)
        let context = UIGraphicsGetCurrentContext()
        currentImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - 100))
        CGContextMoveToPoint(context, fromPoint.x, fromPoint.y)
        CGContextAddLineToPoint(context, toPoint.x, toPoint.y)
        CGContextStrokePath(context)
        currentImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        singlePoint = false
        if let touch = touches.first as UITouch! {
            let currentPoint = touch.locationInView(view)
            drawLine(from: mostRecentPoint, to: currentPoint)
            mostRecentPoint = currentPoint
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if singlePoint {
            drawLine(from: mostRecentPoint, to: mostRecentPoint)
        }
        UIGraphicsBeginImageContext(storedImageView.frame.size)
        storedImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - 100), blendMode: .Normal, alpha: 1.0)
        //saves everything to the screen
        currentImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - 100), blendMode: .Normal, alpha: opacity)
        storedImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        currentImageView.image = nil
    }
    
    // following four: some kind of pop up tab
    
    func onTappedColorButton(sender: AnyObject) {
    }
    
    func onTappedEraserButton(sender: AnyObject) {
    }
    
    func onTappedOpacityButton(sender: AnyObject) {
    }
    
    func onTappedWidthButton(sender: AnyObject) {
    }
    
    // segue, this view slides left
    
    func onTappedArrowButton(sender: AnyObject) {
    }
    
    
}

