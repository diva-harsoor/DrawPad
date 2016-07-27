//
//  ViewController.swift
//  DrawingPad
//
//  Created by Diva Harsoor on 7/24/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var label: UILabel!
    var storedImageView = UIImageView()
    var currentImageView = UIImageView()
    var colorButton = UIButton(), eraserButton = UIButton(), widthButton = UIButton(), arrowButton = UIButton()
    var buttons : [UIButton]!
    var imageNames : [String]!
    var tagForSegue = Int()
    var widthSlider = UISlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttons = [colorButton, eraserButton, widthButton, arrowButton]
        
        imageNames = ["colorImage", "eraserImage", "widthImage", "arrowImage"]
        
        storedImageView = UIImageView(frame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 100))
        self.view.addSubview(storedImageView)
        currentImageView = UIImageView(frame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 100))
        self.view.addSubview(currentImageView)
        
        for i in 0..<buttons.count {
            var image = UIImage(named: imageNames[i]) as UIImage?
            image = resize(image!, newWidth: 60)
            buttons[i] = UIButton(type: UIButtonType.Custom) as UIButton
            buttons[i].frame = CGRectMake(CGFloat(i) * 60, view.frame.size.height - 60, 60, 60)
            buttons[3].frame = CGRectMake(view.frame.size.width - 60, view.frame.size.height - 60, 60, 60)
            buttons[i].setImage(image, forState: .Normal)
            buttons[i].addTarget(self, action: #selector(self.onTappedButton), forControlEvents:.TouchUpInside)
            self.view.addSubview(buttons[i])
            buttons[i].tag = i
        }
        
        widthSlider = UISlider(frame:CGRectMake(190, view.frame.size.height - 45, 150, 30))
        widthSlider.minimumValue = 1.0
        widthSlider.maximumValue = 30.0
        widthSlider.value = 1.0
        widthSlider.continuous = true
        widthSlider.addTarget(self, action: #selector(widthValueDidChange), forControlEvents: .ValueChanged)
        self.view.addSubview(widthSlider)
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
    
    func widthValueDidChange(sender: UISlider) {
        width = CGFloat(widthSlider.value)
    }
    
    var mostRecentPoint = CGPoint.zero
    var singlePoint = true
    var color = UIColor.blackColor()
    var width : CGFloat = 1.0
    
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
        CGContextSetStrokeColorWithColor(context, color.CGColor)
        CGContextSetLineCap(context, .Round)
        CGContextSetLineWidth(context, width)
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
        currentImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - 100), blendMode: .Normal, alpha: 1.0)
        storedImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        currentImageView.image = nil
    }
    
    var originalColor = UIColor()
    var originalWidth = CGFloat()
    var originalOpacity = CGFloat()

    func onTappedButton(sender: UIButton) {
        switch(sender.tag) {
        case 0:
            self.tagForSegue = 0
            performSegueWithIdentifier("ParamSettings", sender: self)
        case 1:
            var image = UIImage(named: "pencilImage") as UIImage!
            image = resize(image!, newWidth: 60)
            buttons[1].setImage(image, forState: UIControlState.Normal)
            sender.tag = 4
            originalColor = color
            originalWidth = width
            color = UIColor.whiteColor()
            width = 10.0
            sender.tag = 3
        case 2:
            self.tagForSegue = 2
        case 3:
            var image = UIImage(named: "eraserImage") as UIImage?
            image = resize(image!, newWidth: 60)
            buttons[1].setImage(image, forState: .Normal)
            color = originalColor
            width = originalWidth
            sender.tag = 1
        default:
            self.tagForSegue = 4
        }
    }
    
    @IBAction func prepareForUnwind(unwindSegue: UIStoryboardSegue) {
        let mvc = unwindSegue.sourceViewController as! ParamSettingsViewController
        color = mvc.color
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dvc = segue.destinationViewController as! ParamSettingsViewController
        dvc.buttonTag = tagForSegue
    }    
}

